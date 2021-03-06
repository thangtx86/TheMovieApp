import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movieapp/data/remote/model/movie.dart';
import 'package:movieapp/utils/constans.dart';
import 'package:movieapp/utils/dimens.dart';

class MovieItem extends StatelessWidget {
  final Function(Movie) onItemClick;
  const MovieItem({Key? key, required this.movie, required this.onItemClick})
      : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: GestureDetector(
        onTap: () {
          onItemClick(movie);
        },
        child: Column(
          children: <Widget>[
            Hero(
              tag: movie.id ?? 0,
              child: Container(
                width: size.width / 3,
                height: size.height / 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6.0),
                  ),
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: NetworkImage(IMAGE_PATH_SMALL + movie.posterPath!),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(
              height: m4Size,
            ),
            Container(
              width: size.width / 3,
              child: Text(
                movie.title ?? "",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  height: 1.2,
                  fontWeight: FontWeight.bold,
                  fontSize: m18Size,
                ),
              ),
            ),
            SizedBox(
              height: m5Size,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RatingBar.builder(
                  itemSize: 12,
                  initialRating: (movie.voteAverage ?? 0) / 2,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => Icon(
                    EvaIcons.star,
                    color: Colors.yellow,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(width: 5.0),
                Text(
                  movie.voteAverage.toString(),
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
