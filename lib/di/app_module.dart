import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:movieapp/screens/home/home_bloc.dart';
import 'package:movieapp/screens/movie_list/movie_list_bloc.dart';
import 'package:movieapp/screens/splash/splash_bloc.dart';
import 'package:movieapp/data/network/api_impl.dart';
import 'package:movieapp/data/network/api_movie.dart';
import 'package:movieapp/data/remote/respository/imovie_respository.dart';
import 'package:movieapp/data/remote/respository/movie_respository.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  await provideModule();
  provideBlocModule();
}

Future provideModule() async {
  var dio = Dio(
    BaseOptions(
      connectTimeout: 10000,
      receiveTimeout: 6000,
    ),
  );
  locator.registerSingleton<Dio>(dio);
  locator.registerSingleton<ApiImpl>(
    ApiMovie(
      locator<Dio>(),
    ),
  );

  locator.registerSingleton<IMovieRespository>(
      MovieRespository(locator<ApiImpl>()));
}

void provideBlocModule() {
  locator.registerSingleton<SplashBloc>(SplashBloc());
  locator
      .registerFactory<HomeBloc>(() => HomeBloc(locator<IMovieRespository>()));

  locator.registerFactory<MovieListBloc>(
      () => MovieListBloc(locator<IMovieRespository>()));
}
