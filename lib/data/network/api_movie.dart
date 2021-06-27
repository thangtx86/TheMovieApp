import 'package:dio/dio.dart';
import 'package:movieapp/data/network/api_impl.dart';
import 'package:movieapp/data/remote/model/categories.dart';
import 'package:movieapp/data/remote/model/genre_response.dart';
import 'package:movieapp/data/remote/model/movie_list_response.dart';

class ApiMovie implements ApiImpl {
  Dio _dio;

  ApiMovie(this._dio);

  static const String _BASE_URL = 'https://api.themoviedb.org/3';
  static const String _API_KEY = "8a1227b5735a7322c4a43a461953d4ff";

  @override
  Future<MoviesResponse> fetchMovieByCategory(
      Category category, int page) async {
    final movieByCategory = '$_BASE_URL/movie/${category.query}';
    var params = {
      "api_key": _API_KEY,
      "language": "en-US",
      "page": page,
    };
    try {
      Response response =
          await _dio.get(movieByCategory, queryParameters: params);
      return MoviesResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MoviesResponse.error("$error");
    }
  }

  @override
  Future<GenresRespone> fetchGenreMovie() async {
    final genreMovie = '$_BASE_URL/genre/movie/list';
    var params = {
      "api_key": _API_KEY,
      "language": "en-US",
    };

    try {
      Response response = await _dio.get(genreMovie, queryParameters: params);
      return GenresRespone.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GenresRespone.error("$error");
    }
  }
}
