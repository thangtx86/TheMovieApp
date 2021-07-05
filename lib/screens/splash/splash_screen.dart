import 'package:flutter/material.dart';
import 'package:movieapp/base/base_bloc_provider.dart';
import 'package:movieapp/screens/splash/splash_bloc.dart';
import 'package:movieapp/di/app_module.dart';
import 'package:movieapp/router/router_config.dart';

import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseProviderBloc<SplashBloc>(
      bloc: locator<SplashBloc>(),
      child: _SplashWidget(),
    );
  }
}

class _SplashWidget extends StatefulWidget {
  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<_SplashWidget> {
  late SplashBloc _splashBloc;

  @override
  void initState() {
    _splashBloc = context.read<SplashBloc>();
    _splashBloc.fakeLoading();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _splashBloc.splashStream.listen((event) {
      if (event == SplashState.DONE) {
        Navigator.pushReplacementNamed(context, RouteConfig.HOME_SCREEN);
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF243142),
      child: Center(
          child: Text(
        "Movie App",
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          decoration: TextDecoration.none,
        ),
      )),
    );
  }
}
