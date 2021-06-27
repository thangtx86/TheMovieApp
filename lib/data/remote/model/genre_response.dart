import 'package:movieapp/data/remote/model/genre.dart';

class GenresRespone {
  List<Genre> genres;
  String error = '';

  GenresRespone({this.genres});
  GenresRespone.error(this.error);

  GenresRespone.fromJson(Map<String, dynamic> json) {
    if (null != json['genres']) {
      genres = new List<Genre>();
      json['genres'].forEach((item) {
        genres.add(new Genre.fromJson(item));
      });
    }
  }
}
