import 'package:movieapp/data/remote/model/categories.dart';
import 'package:movieapp/data/remote/model/genre.dart';
import 'package:movieapp/data/remote/model/genre_response.dart';
import 'package:movieapp/data/remote/model/movie_list_response.dart';

abstract class ApiImpl {
  Future<MoviesResponse> fetchMovieByCategory(Category category, int page);
  Future<GenresRespone> fetchGenreMovie();
}
