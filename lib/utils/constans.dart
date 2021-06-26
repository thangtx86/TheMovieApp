// Colos that use in our app
import 'package:flutter/material.dart';
import 'package:movieapp/data/remote/model/categories.dart';

const kSecondaryColor = Color(0xFFf48210);
const kTextColor = Colors.white;
const kTextLightColor = Colors.white70;
const kFillStarColor = Color(0xFFFCC419);
const kColorChipItem = Color(0xFF192431);
const kColorItemDarker = Color(0xFF002431);
const mainColor = Color(0xFF151C26);
const secondColor = Color(0xFFf4C10F);
const titleColor = Color(0xFF5a606b);

const listCategory = [
  Category(name: "Now Playing", query: "now_playing"),
  Category(name: "Popular", query: "popular"),
  Category(name: "Top Rated", query: "top_rated"),
  Category(name: "Coming Soon", query: "upcoming"),
];
