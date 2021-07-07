import 'package:dio/dio.dart';
import 'package:movieapp/base/base_bloc.dart';
import 'package:movieapp/base/base_state.dart';
import 'package:movieapp/data/remote/model/movie.dart';
import 'package:movieapp/data/remote/model/movie_detail_response.dart';
import 'package:movieapp/data/remote/respository/imovie_respository.dart';
import 'package:movieapp/utils/utils.dart';
import 'package:rxdart/subjects.dart';

class MovieDetailBloc extends BaseBloc {
  final IMovieRespository _movieRespository;
  MovieDetailBloc(this._movieRespository);

  BehaviorSubject<BaseState> _movieByDetailSubject =
      BehaviorSubject<BaseState>();

  //stream
  Stream<BaseState> get moviesByCategory => _movieByDetailSubject.stream;

  Future fetchMovieDetail(int id) async {
    _movieByDetailSubject.add(StateLoading());
    await Future.delayed(Duration(milliseconds: 1000));
    var response = await _movieRespository.fetchMovieDetail(id);
    if (response != null) {
      logInfo("movie-detail", "${response.overview}");
      _movieByDetailSubject.add(StateLoaded<MovieDetailResponse>(response));
    }
  }

  @override
  void dispose() {
    _movieByDetailSubject.close();
  }
}
