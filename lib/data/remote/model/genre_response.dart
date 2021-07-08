import 'package:json_annotation/json_annotation.dart';
import 'package:movieapp/data/remote/model/genre.dart';

class GenresRespone {
  GenresRespone({this.genres});

  List<Genre>? genres;
  String error = '';

  GenresRespone.error(this.error);

  GenresRespone.fromJson(Map<String, dynamic> json) {
    if (null != json['genres']) {
      genres = [];

      json['genres'].forEach((item) {
        genres?.add(Genre.fromJson(item));
      });
    }
  }
}
