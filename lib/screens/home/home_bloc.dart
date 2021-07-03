import 'package:movieapp/base/base_bloc.dart';
import 'package:movieapp/base/base_state.dart';
import 'package:movieapp/data/remote/model/categories.dart';
import 'package:movieapp/data/remote/model/genre.dart';
import 'package:movieapp/data/remote/model/movie.dart';
import 'package:movieapp/data/remote/respository/imovie_respository.dart';
import 'package:movieapp/data/remote/respository/movie_respository.dart';

import 'package:movieapp/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

import 'package:rxdart/subjects.dart';

class HomeBloc extends BaseBloc {
  final IMovieRespository _movieRespository;

  static const TAG = "HOME_BLOC";

  static const _FIRST_PAGE = 1;

  HomeBloc(this._movieRespository) {
    logInfo(TAG, "HomeBloc is init...");
    _listenCategoryChange();
  }

  BehaviorSubject<BaseState> _movieByCategorySubject =
      BehaviorSubject<BaseState>();

  BehaviorSubject<Category> _categorySubject =
      BehaviorSubject.seeded(listCategory[0]);

  BehaviorSubject<BaseState> _genresSubject = BehaviorSubject<BaseState>();

  BehaviorSubject<BaseState> _movieDiscoverSubject =
      BehaviorSubject<BaseState>();

  //stream
  Stream<BaseState> get moviesByCategory => _movieByCategorySubject.stream;

  Category get currentCategory => _categorySubject.stream.value;

  Stream<BaseState> get genresListStream => _genresSubject.stream;

  Stream<BaseState> get moviesDiscover => _movieDiscoverSubject.stream;

  Future requestMovieByCategories(Category category, int page) async {
    _movieByCategorySubject.add(StateLoading());
    await Future.delayed(Duration(milliseconds: 1000));
    var response = await _movieRespository.fetchMovieByCategory(category, page);
    if (response.error.isEmpty) {
      _movieByCategorySubject.add(StateLoaded<List<Movie>>(response.results!));
      logInfo(TAG, "Movie Categories: " + response.results!.length.toString());
    } else {
      _movieByCategorySubject.add(StateError(response.error));
      logError(TAG, response.error);
    }
  }

  Future requestGenres() async {
    _genresSubject.add(StateLoading());
    await Future.delayed(Duration(milliseconds: 1000));
    var response = await _movieRespository.fetchGenreMovie();
    if (response.error.isEmpty) {
      _genresSubject.add(StateLoaded<List<Genre>>(response.genres!));
      logInfo(TAG, "Genre: " + response.genres!.length.toString());
    } else {
      _genresSubject.add(StateError(response.error));
      logError(TAG, response.error);
    }
  }

  Future fetchDiscoverMovie() async {
    _movieDiscoverSubject.add(StateLoading());
    await Future.delayed(Duration(milliseconds: 1000));
    var response = await _movieRespository.fetchDiscoverMovie(_FIRST_PAGE);
    if (response.error.isEmpty) {
      _movieDiscoverSubject.add(StateLoaded<List<Movie>>(response.results!));

      logInfo(TAG, "Movie Discover: " + response.results!.length.toString());
    } else {
      _movieDiscoverSubject.add(StateError(response.error));
      logError(TAG, response.error);
    }
  }

  void onChangeCategory(Category category) {
    _categorySubject.add(category);
  }

  void _listenCategoryChange() {
    _categorySubject.listen((category) {
      requestMovieByCategories(category, _FIRST_PAGE);
    });
  }

  dispose() {
    logInfo(TAG, "HomeBloc is dispose...");
    _movieByCategorySubject.close();
    _categorySubject.close();
    _genresSubject.close();
    _movieDiscoverSubject.close();
  }
}
