import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/base/base_bloc_provider.dart';
import 'package:movieapp/di/app_module.dart';
import 'package:movieapp/router/router_config.dart';
import 'package:movieapp/screens/home/home_bloc.dart';
import 'package:movieapp/screens/signin/login_bloc.dart';
import 'package:movieapp/screens/signin/login_screen.dart';
import 'package:movieapp/utils/color.dart';
import 'package:movieapp/utils/constans.dart';
import 'package:provider/provider.dart';

class NavigationDawable extends StatelessWidget {
  const NavigationDawable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProviderBloc<LoginBloc>(
      bloc: locator<LoginBloc>(),
      child: NavigationWidget(),
    );
  }
}

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({Key? key}) : super(key: key);

  @override
  _NavigationWidgetState createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  late LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = context.read<LoginBloc>();
    _loginBloc.currentUser.listen((fbUser) {
      if (fbUser == null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mMainColor,
      child: ListView(
        children: [
          StreamBuilder<User?>(
            stream: _loginBloc.currentUser,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                var user = snapshot.data!;
                return Container(
                  padding: EdgeInsets.only(top: 40),
                  color: mMainColor,
                  alignment: Alignment.center,
                  height: 200,
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage("${user.photoURL}"),
                        maxRadius: 40,
                        minRadius: 30,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text("${user.displayName}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white)),
                      Text("${user.email}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white))
                    ],
                  ),
                );
              }
            },
          ),
          _buildItem("Home", Icons.home, () {
            Navigator.pop(context);
          }),
          _buildItem("Favorite Movies", Icons.favorite, () {
            Navigator.pop(context); // close(context);
          }),
          _buildItem("About", Icons.info, () {
            Navigator.pop(context);
          }),
          _buildItem("Logout", Icons.logout, () {
            // FirebaseAuth.instance.signOut();
            _loginBloc.logoutWithFb()

                // Navigator.pushNamed(context, RouteConfig.LOGIN_SCREEN);
                ;
          }),
        ],
      ),
    );
  }

  Widget _buildItem(String title, IconData iconData, Function onClick) {
    return Material(
      color: mMainColor,
      child: InkWell(
        onTap: () {
          onClick();
        },
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
            children: [
              Icon(
                iconData,
                color: Colors.white,
              ),
              SizedBox(
                width: 24,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
