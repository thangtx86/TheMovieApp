import 'package:movieapp/base/base_bloc.dart';
import 'package:movieapp/base/base_state.dart';
import 'package:movieapp/data/remote/model/categories.dart';
import 'package:movieapp/data/remote/model/movie.dart';

import 'package:movieapp/data/remote/respository/imovie_respository.dart';
import 'package:movieapp/utils/utils.dart';
import 'package:rxdart/subjects.dart';

class MovieListBloc extends BaseBloc {
  static const TAG = "MovieListBloc";
  final IMovieRespository _movieRespository;

  List<Movie?> _movieCached = [];
  int _currentPage = 2; //start load more at 2
  bool hasMoreData = true;

  MovieListBloc(this._movieRespository);

  BehaviorSubject<BaseState> _movieByCategorySubject =
      BehaviorSubject<BaseState>();

  //stream
  Stream<BaseState> get moviesByCategory => _movieByCategorySubject.stream;

  Future fetchMovieListCateogries(Category category) async {
    _movieByCategorySubject.add(StateLoading());
    await Future.delayed(Duration(milliseconds: 1000));
    var response = await _movieRespository.fetchMovieByCategory(category, 1);

    if (_currentPage == response.totalPages) {
      hasMoreData = false;
    }

    List<Movie> newList = response.results ?? [];
    logInfo(
        TAG, "Movie ${category.name}: newList: " + newList.length.toString());

    if (response.error.isEmpty) {
      _movieCached.addAll(newList);
      if (hasMoreData) _movieCached.add(null);
      _movieByCategorySubject.add(StateLoaded<List<Movie?>>(_movieCached));
      logInfo(
          TAG,
          "Movie ${category.name}: newListCache: " +
              _movieCached.length.toString());
    } else {
      _movieByCategorySubject.add(StateError(response.error));
    }

    // if (response.error.isEmpty) {
    //   _movieByCategorySubject.add(StateLoaded<List<Movie>>(response.results!));
    //   logInfo(TAG,
    //       "Movie ${category.name}: " + response.results!.length.toString());
    // } else {
    //   _movieByCategorySubject.add(StateError(response.error));
    //   logError(TAG, response.error);
    // }
  }

  Future loadMore(Category category) async {
    try {
      if (!hasMoreData) return;
      var response =
          await _movieRespository.fetchMovieByCategory(category, _currentPage);

      if (_currentPage >= response.totalPages!) {
        hasMoreData = false;
      }

      List<Movie> newList = response.results ?? [];
      if (response.error.isEmpty) {
        _movieCached.remove(null);
        _currentPage++;
        _movieCached.addAll(newList);
        if (hasMoreData) _movieCached.add(null);
      } else {
        if (_movieCached.contains(null)) _movieCached.remove(null);
      }

      _movieByCategorySubject.add(StateLoaded<List<Movie?>>(_movieCached));
    } catch (e) {}
  }

  @override
  void dispose() {
    _movieByCategorySubject.close();
  }
}
