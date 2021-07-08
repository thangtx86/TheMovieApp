import 'package:json_annotation/json_annotation.dart';

part 'genre.g.dart';

@JsonSerializable()
class Genre {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name", defaultValue: "")
  String? name;

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  Genre({this.id, this.name});
}
