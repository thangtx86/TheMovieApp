import 'package:flutter/material.dart';
import 'package:movieapp/data/remote/model/categories.dart';
import 'package:movieapp/screens/detail/movie_detail.dart';
import 'package:movieapp/screens/home/home_screens.dart';
import 'package:movieapp/screens/movie_list/movie_list_screen.dart';
import 'package:movieapp/screens/splash/splash_screen.dart';

class RouteConfig {
  static const SPLASH_SCREEN = "/splash";
  static const HOME_SCREEN = "/home";
  static const SHOW_ALL = "/show_all";
  static const DETAIL = "/detail";

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    Route? result;
    switch (settings.name) {
      case SPLASH_SCREEN:
        result = MaterialPageRoute(builder: (_) => SplashScreen());
        break;
      case HOME_SCREEN:
        result = PageRouteBuilder(
          pageBuilder: (_, __, ___) => HomeScreen(),
          transitionDuration: Duration(milliseconds: 400),
        );
        break;
      case SHOW_ALL:
        if (args is Category) {
          result = MaterialPageRoute(
              builder: (_) => MovieListScreen(category: args));
        }
        break;
      case DETAIL:
        if (args is int) {
          result = MaterialPageRoute(
              builder: (_) => MovieDetailScreen(movieId: args));
        }
        break;
    }
    return result;
  }
}
