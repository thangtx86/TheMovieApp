import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movieapp/utils/constans.dart';

class HeaderMovieDetail extends StatelessWidget {
  const HeaderMovieDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.35,
      child: Stack(
        children: <Widget>[
          Container(
            height: size.height * 0.35 - 42,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(IMAGE_DUMMY), fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
          ),
          Positioned(
              bottom: 0,
              left: 32,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                height: 90,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Colors.grey.withOpacity(0.4),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset("assets/images/ic_start.svg"),
                        SizedBox(height: 10.0),
                        Text(
                          "8.2/10",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        SizedBox(height: 4.0),
                        Text("123,323",
                            style: TextStyle(
                                color: Color(0xFF9A9BB2), fontSize: 12)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset("assets/images/ic_star_grey.svg"),
                        SizedBox(height: 10.0),
                        Text(
                          "8.2/10",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          "123,323",
                          style:
                              TextStyle(color: Color(0xFF9A9BB2), fontSize: 12),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Color(0xFF151CF66)),
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 4, bottom: 5),
                          child: Text(
                            '86',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "8.2/10",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          "123,323",
                          style:
                              TextStyle(color: Color(0xFF9A9BB2), fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
