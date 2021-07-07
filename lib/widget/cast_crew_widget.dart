import 'package:flutter/material.dart';
import 'package:movieapp/utils/constans.dart';
import 'package:movieapp/utils/dimens.dart';

class CatCrewWidget extends StatelessWidget {
  const CatCrewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: m25Size),
      alignment: Alignment.centerLeft,
      child: Column(
        children: <Widget>[
          Text(
            "Cast & Crew",
            style: TextStyle(fontSize: m20Size),
          ),
          SizedBox(
            height: m20Size,
          ),
          _buildCastWidget(),
        ],
      ),
    );
  }

  Widget _buildCastWidget() {
    return Container(
      width: m100Size,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            minRadius: m30Size,
            maxRadius: m45Size,
            backgroundImage: NetworkImage(IMAGE_DUMMY),
          ),
          SizedBox(
            height: m6Size,
          ),
          Text(
            "James Mangol",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: m18Size),
          ),
          SizedBox(
            height: m8Size,
          ),
          Text(
            "Director",
            style: TextStyle(color: Color(0xFF9A9BB2), fontSize: m16Size),
          ),
        ],
      ),
    );
  }
}
