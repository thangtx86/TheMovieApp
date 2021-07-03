import 'package:flutter/material.dart';

class Category {
  final String? name;
  final String? query;

  const Category({@required this.name, @required this.query});
}

const listCategory = [
  Category(name: "Now Playing", query: "now_playing"),
  Category(name: "Popular", query: "popular"),
  Category(name: "Top Rated", query: "top_rated"),
  Category(name: "Upcoming", query: "upcoming"),
];
