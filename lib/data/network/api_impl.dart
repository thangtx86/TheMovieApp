import 'package:movieapp/data/remote/model/categories.dart';
import 'package:movieapp/data/remote/model/genre_response.dart';
import 'package:movieapp/data/remote/model/movie.dart';
import 'package:movieapp/data/remote/model/movie_detail_response.dart';
import 'package:movieapp/data/remote/model/movie_list_response.dart';

abstract class ApiImpl {
  // fetch movie api for category
  Future<MoviesResponse> fetchMovieByCategory(Category category, int page);
  // fetch movie genre
  Future<GenresRespone> fetchGenreMovie();
  // fetch dicover movie
  Future<MoviesResponse> fetchDicoverMovie(int page);

  Future<MovieDetailResponse> fetchMovieDetail(int id);
}
