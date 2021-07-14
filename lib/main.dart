import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/di/app_module.dart';
import 'package:movieapp/router/router_config.dart';

import 'package:movieapp/utils/color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteConfig.SPLASH_SCREEN,
      theme: _kMovieTheme,
      onGenerateRoute: (settings) => RouteConfig.generateRoute(settings),
    );
  }

  //   Route<dynamic>_getRoute(RouteSettings settings) {
  //   if (settings.name != '/login') {
  //     return null;
  //   }

  //   return MaterialPageRoute<void>(
  //     settings: settings,
  //     builder: (BuildContext context) => SplashScreen(),
  //     fullscreenDialog: true,
  //   );
  // }

}

final ThemeData _kMovieTheme = _buildMovieTheme();

ThemeData _buildMovieTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: mMainColor,
      onPrimary: mMainColor,
      secondary: mMainColor,
    ),
    appBarTheme: base.appBarTheme.copyWith(
      backwardsCompatibility: false,
    ),
  );
}
