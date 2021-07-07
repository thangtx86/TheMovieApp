import 'package:flutter/material.dart';
import 'package:movieapp/utils/constans.dart';

class CatCrewWidget extends StatelessWidget {
  const CatCrewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      alignment: Alignment.centerLeft,
      child: Column(
        children: <Widget>[
          Text(
            "Cast & Crew",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20,
          ),
          _buildCastWidget(),
        ],
      ),
    );
  }

  Widget _buildCastWidget() {
    return Container(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            minRadius: 30,
            maxRadius: 45,
            backgroundImage: NetworkImage(IMAGE_DUMMY),
          ),
          SizedBox(
            height: 6.0,
          ),
          Text(
            "James Mangol",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            "Director",
            style: TextStyle(color: Color(0xFF9A9BB2), fontSize: 16),
          ),
        ],
      ),
    );
  }
}
