import 'package:movieapp/base/base_bloc.dart';
import 'package:movieapp/base/base_state.dart';
import 'package:movieapp/data/remote/model/categories.dart';
import 'package:movieapp/data/remote/model/genre.dart';
import 'package:movieapp/data/remote/model/genre_response.dart';
import 'package:movieapp/data/remote/model/movie.dart';
import 'package:movieapp/data/remote/respository/movie_respository.dart';

import 'package:movieapp/utils/constans.dart';

import 'package:rxdart/subjects.dart';

class HomeBloc extends BaseBloc {
  final MovieRespository _movieRespository;

  static const _FIRST_PAGE = 1;

  HomeBloc(this._movieRespository) {
    print(" homebloc create");
    _listenCategoryChange();
  }

  BehaviorSubject<BaseState> _movieByCategorySubject =
      BehaviorSubject<BaseState>();

  BehaviorSubject<Category> _categorySubject =
      BehaviorSubject.seeded(listCategory[0]);

  BehaviorSubject<BaseState> _genresSubject = BehaviorSubject<BaseState>();

  //stream
  Stream<BaseState> get moviesByCategory => _movieByCategorySubject.stream;

  Category get currentCategory => _categorySubject.stream.value;

  Stream<BaseState> get genresListStream => _genresSubject.stream;

  void _listenCategoryChange() {
    _categorySubject.listen((category) {
      requestMovieByCategories(category, _FIRST_PAGE);
    });
  }

  Future requestMovieByCategories(Category category, int page) async {
    _movieByCategorySubject.add(StateLoading());
    await Future.delayed(Duration(milliseconds: 1000));
    var response = await _movieRespository.fetchMovieByCategory(category, page);
    if (response.error.isEmpty) {
      _movieByCategorySubject.add(StateLoaded<List<Movie>>(response.results));

      print("-------OK+ " + response.results.length.toString());
    } else {
      _movieByCategorySubject.add(StateError("Fetch Api Error"));
      print("-------Erooor");
    }
  }

  Future requestGenres() async {
    await Future.delayed(Duration(milliseconds: 1000));

    var response = await _movieRespository.fetchGenreMovie();
    if (response.error.isEmpty) {
      _genresSubject.add(StateLoaded<List<Genre>>(response.genres));
      print("Genres----" + response.genres.length.toString());
    } else {
      _genresSubject.add(StateError("sssss"));
    }
  }

  void onChangeCategory(Category category) {
    _categorySubject.add(category);
  }

  dispose() {
    print(" homebloc dispose");
    _movieByCategorySubject.close();
    _categorySubject.close();
  }
}
