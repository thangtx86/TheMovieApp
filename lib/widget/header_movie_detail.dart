import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieapp/data/remote/model/movie_detail_response.dart';
import 'package:movieapp/utils/constans.dart';
import 'package:movieapp/utils/dimens.dart';

class HeaderMovieDetail extends StatelessWidget {
  const HeaderMovieDetail({Key? key, required this.movie}) : super(key: key);
  final MovieDetailResponse movie;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.35,
      child: Stack(children: <Widget>[
        Container(
          height: size.height * 0.35 - 42,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: movie.posterPath != null
                      ? NetworkImage(
                          IMAGE_PATH_LARGE + (movie.posterPath ?? ""))
                      : AssetImage(IMAGE_PATH_DEFAULT) as ImageProvider,
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(m30Size),
                  bottomRight: Radius.circular(m30Size))),
        ),
        Positioned(
          top: 60,
          left: 16,
          child: Container(
            child: GestureDetector(
              onTap: () => {Navigator.pop(context)},
              child: FaIcon(Icons.arrow_back_sharp, color: Colors.white),
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            left: m32Size,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: m50Size),
              height: m90Size,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: m50Size,
                      color: Colors.grey.withOpacity(0.4),
                    )
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(m30Size),
                      bottomLeft: Radius.circular(m30Size))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset("assets/images/ic_start.svg"),
                      SizedBox(height: m10Size),
                      Text(
                        "${movie.voteAverage} /10",
                        style:
                            TextStyle(color: Colors.black, fontSize: m16Size),
                      ),
                      SizedBox(height: m4Size),
                      Text("${movie.voteCount}",
                          style: TextStyle(
                              color: Color(0xFF9A9BB2), fontSize: m12Size)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: m9Size),
                      SvgPicture.asset("assets/images/ic_star_grey.svg"),
                      SizedBox(height: m10Size),
                      Text(
                        "Rate This",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: m16Size,
                            fontWeight: FontWeight.w500),
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
                            left: m10Size,
                            right: m10Size,
                            top: m4Size,
                            bottom: m5Size),
                        child: Text(
                          '86',
                          style: TextStyle(
                            fontSize: m14Size,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: m10Size),
                      Text(
                        "8.2/10",
                        style:
                            TextStyle(color: Colors.black, fontSize: m16Size),
                      ),
                      SizedBox(height: m4Size),
                      Text(
                        "123,323",
                        style: TextStyle(
                            color: Color(0xFF9A9BB2), fontSize: m12Size),
                      ),
                    ],
                  )
                ],
              ),
            ))
      ]),
    );
  }
}
