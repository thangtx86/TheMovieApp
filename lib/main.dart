import 'package:flutter/material.dart';
import 'package:movieapp/di/app_module.dart';
import 'package:movieapp/router/router_config.dart';
import 'package:movieapp/screens/splash/splash_screen.dart';
import 'package:movieapp/utils/constans.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      primary: mainColor,
      onPrimary: mainColor,
      secondary: mainColor,
    ),
    appBarTheme: base.appBarTheme.copyWith(
      backwardsCompatibility: false,
    ),
  );
}
