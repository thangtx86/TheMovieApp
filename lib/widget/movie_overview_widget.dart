import 'package:flutter/material.dart';
import 'package:movieapp/utils/constans.dart';
import 'package:movieapp/utils/dimens.dart';

class MovieOverviewWidget extends StatelessWidget {
  const MovieOverviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: m25Size),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Plot Summary",
            style: TextStyle(fontSize: m20Size),
          ),
          SizedBox(
            height: m20Size,
          ),
          Text(
            "$dumy_string",
            textAlign: TextAlign.justify,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Color(0xFF737599)),
          )
        ],
      ),
    );
  }
}
