import 'package:flutter/material.dart';
import 'package:movieapp/screens/home/home_screens.dart';
import 'package:movieapp/screens/splash/splash_screen.dart';

class RouteConfig {
  static const SPLASH_SCREEN = "/splash";
  static const HOME_SCREEN = "/home";

  static Route<dynamic>? generateRoute(RouteSettings settings) {
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
    }
    return result;
  }
}
