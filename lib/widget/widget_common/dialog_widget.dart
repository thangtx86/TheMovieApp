import 'package:flutter/material.dart';

class LoadingProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      height: size.height,
      width: size.width,
      child: CircularProgressIndicator(),
    );
  }
}
