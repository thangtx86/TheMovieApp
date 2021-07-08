import 'package:flutter/material.dart';
import 'package:movieapp/data/remote/model/movie.dart';
import 'package:movieapp/extensions/extensions.dart';
import 'package:movieapp/utils/constans.dart';
import 'package:movieapp/utils/dimens.dart';

class MovieItemStack extends StatelessWidget {
  const MovieItemStack({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: m10Size, bottom: m10Size, right: m16Size),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(m12Size),
              ),
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  image: movie.backdropPath != null
                      ? NetworkImage(IMAGE_PATH_SMALL + movie.backdropPath!)
                      : AssetImage(IMAGE_PATH_DEFAULT) as ImageProvider,
                  fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: m10Size,
            right: m10Size,
            child: Container(
              alignment: Alignment.center,
              width: m45Size,
              height: m45Size,
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFF99F00), Color(0xFFDB3069)],
                ),
                shape: BoxShape.circle,
              ),
              child: Text(
                movie.voteAverage.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.releaseDate?.getYear() ?? "",
                  style: TextStyle(color: Colors.white, fontSize: m16Size),
                ),
                Text(
                  movie.title?.toUpperCase() ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: m16Size,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
