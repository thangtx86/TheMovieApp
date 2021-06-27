import 'package:movieapp/data/network/api_impl.dart';
import 'package:movieapp/data/remote/model/categories.dart';
import 'package:movieapp/data/remote/model/genre_response.dart';
import 'package:movieapp/data/remote/model/movie_list_response.dart';
import 'package:movieapp/data/remote/respository/imovie_respository.dart';

class MovieRespository implements IMovieRespository {
  ApiImpl _apiImpl;

  MovieRespository(this._apiImpl);

  @override
  Future<MoviesResponse> fetchMovieByCategory(
      Category category, int page) async {
    return _apiImpl.fetchMovieByCategory(category, page);
  }

  @override
  Future<GenresRespone> fetchGenreMovie() {
    return _apiImpl.fetchGenreMovie();
  }
}
