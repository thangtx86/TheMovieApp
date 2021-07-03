import 'package:movieapp/data/remote/model/movie.dart';

class MoviesResponse {
  int? totalPages;
  Dates? dates;
  int? page;
  int? totalResults;
  List<Movie>? results;
  String error = '';
  MoviesResponse(
      {this.totalPages,
      this.dates,
      this.page,
      this.totalResults,
      this.results});

  MoviesResponse.error(this.error);

  MoviesResponse.fromJson(Map<String, dynamic> json) {
    totalPages = json['total_pages'];
    dates = json['dates'] != null ? new Dates.fromJson(json['dates']) : null;
    page = json['page'];
    totalResults = json['total_results'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(new Movie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_pages'] = this.totalPages;
    if (this.dates != null) {
      data['dates'] = this.dates?.toJson();
    }
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    if (this.results != null) {
      data['results'] = this.results?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dates {
  String? minimum;
  String? maximum;

  Dates({this.minimum, this.maximum});

  Dates.fromJson(Map<String, dynamic> json) {
    minimum = json['minimum'];
    maximum = json['maximum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minimum'] = this.minimum;
    data['maximum'] = this.maximum;
    return data;
  }
}
