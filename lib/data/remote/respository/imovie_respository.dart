import 'package:movieapp/data/remote/model/categories.dart';
import 'package:movieapp/data/remote/model/genre_response.dart';
import 'package:movieapp/data/remote/model/movie.dart';
import 'package:movieapp/data/remote/model/movie_detail_response.dart';
import 'package:movieapp/data/remote/model/movie_list_response.dart';

abstract class IMovieRespository {
  Future<MoviesResponse> fetchMovieByCategory(Category category, int page);

  Future<GenresRespone> fetchGenreMovie();

  Future<MoviesResponse> fetchDiscoverMovie(int page);

  Future<MovieDetailResponse> fetchMovieDetail(int id);
}
