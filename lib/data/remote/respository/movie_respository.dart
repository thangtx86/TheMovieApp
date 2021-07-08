import 'package:movieapp/data/network/api_impl.dart';
import 'package:movieapp/data/remote/model/cast_crew_response.dart';
import 'package:movieapp/data/remote/model/categories.dart';
import 'package:movieapp/data/remote/model/genre_response.dart';
import 'package:movieapp/data/remote/model/movie_detail_response.dart';
import 'package:movieapp/data/remote/model/movie_list_response.dart';
import 'package:movieapp/data/remote/respository/imovie_respository.dart';

class MovieRespository implements IMovieRespository {
  ApiImpl _apiImpl;

  MovieRespository(this._apiImpl);

  @override
  Future<MoviesResponse> fetchMovieByCategory(
          Category category, int page) async =>
      _apiImpl.fetchMovieByCategory(category, page);

  @override
  Future<GenresRespone> fetchGenreMovie() async => _apiImpl.fetchGenreMovie();

  @override
  Future<MoviesResponse> fetchDiscoverMovie(int page) async =>
      _apiImpl.fetchDicoverMovie(page);

  @override
  Future<MovieDetailResponse> fetchMovieDetail(int id) async =>
      _apiImpl.fetchMovieDetail(id);

  @override
  Future<CastCrewResponse> fetchCastCrew(int movieId) async =>
      _apiImpl.fetchCastCrew(movieId);
}
