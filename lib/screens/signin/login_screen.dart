import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movieapp/base/base_bloc_provider.dart';
import 'package:movieapp/di/app_module.dart';
import 'package:movieapp/screens/home/home_bloc.dart';
import 'package:movieapp/screens/home/home_screens.dart';
import 'package:movieapp/screens/signin/login_bloc.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProviderBloc<LoginBloc>(
      bloc: locator<LoginBloc>(),
      child: LoginWidget(),
    );
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = context.read<LoginBloc>();
    _loginBloc.currentUser.listen((fbUser) {
      if (fbUser != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: size.height,
              color: Color(0xFF243142),
            ),
            _buildHeadrLogin(),
            _buildFormLogin(size)
          ],
        ),
      ),
    ));
  }

  Widget _buildFormLogin(Size size) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        height: (size.height * 0.65),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(55),
          ),
        ),
        child: Padding(
          padding:
              EdgeInsets.only(top: 60, left: 30.0, right: 30.0, bottom: 30.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(143, 148, 251, .2),
                          blurRadius: 20.0,
                          offset: Offset(0, 10))
                    ]),
                child: _buildFormInput(),
              ),
              SizedBox(
                height: 30,
              ),
              _buildButtonLogin(),
              SizedBox(
                height: 20,
              ),
              Text("Or", style: TextStyle(color: Colors.grey, fontSize: 22)),
              SizedBox(
                height: 20,
              ),
              _buildSocialNetworkButton(),
              SizedBox(
                height: 70,
              ),
              Text(
                "Forgot Password?",
                style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialNetworkButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _loginBloc.fbSignIn();
          },
          child: Container(
            width: 145,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            decoration: BoxDecoration(
                color: Color(0xff0C90F2),
                borderRadius: new BorderRadius.all(
                  Radius.circular(20.0),
                )),
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  "assets/images/facebook.svg",
                  width: 30,
                  height: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Facebook",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _loginBloc.ggSignIn();
          },
          child: Container(
            width: 145,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            decoration: BoxDecoration(
                color: Color(0xffF55362),
                borderRadius: new BorderRadius.all(
                  Radius.circular(20.0),
                )),
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  "assets/images/google.svg",
                  width: 30,
                  height: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Google",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildButtonLogin() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(143, 148, 251, 1),
            Color.fromRGBO(143, 148, 251, .6),
          ])),
      child: Center(
        child: Text(
          "Login",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildFormInput() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey[100]!))),
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Email or Phone number",
                hintStyle: TextStyle(color: Colors.grey[400])),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.grey[400])),
          ),
        )
      ],
    );
  }

  Widget _buildHeadrLogin() {
    return Positioned(
      top: 100,
      child: Align(
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginView() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.fill),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    width: 80,
                    left: 30,
                    height: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/light-1.png"),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    width: 80,
                    left: 140,
                    height: 150,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/light-2.png"),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 40,
                    width: 80,
                    height: 150,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/clock.png"),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10))
                        ]),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey[100]!))),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email or Phone number",
                                hintStyle: TextStyle(color: Colors.grey[400])),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey[400])),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(143, 148, 251, 1),
                          Color.fromRGBO(143, 148, 251, .6),
                        ])),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Or",
                      style: TextStyle(color: Colors.grey, fontSize: 22)),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _loginBloc.fbSignIn();
                        },
                        child: Container(
                          width: 145,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                              color: Color(0xff0C90F2),
                              borderRadius: new BorderRadius.all(
                                Radius.circular(20.0),
                              )),
                          child: Row(
                            children: <Widget>[
                              SvgPicture.asset(
                                "assets/images/facebook.svg",
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Facebook",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _loginBloc.ggSignIn();
                        },
                        child: Container(
                          width: 145,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                              color: Color(0xffF55362),
                              borderRadius: new BorderRadius.all(
                                Radius.circular(20.0),
                              )),
                          child: Row(
                            children: <Widget>[
                              SvgPicture.asset(
                                "assets/images/google.svg",
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Google",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Text(
                    "Forgot Password?",
                    style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
