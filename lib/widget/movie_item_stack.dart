import 'package:flutter/material.dart';
import 'package:movieapp/data/remote/model/movie.dart';
import 'package:movieapp/extensions/extensions.dart';

class MovieItemStack extends StatelessWidget {
  const MovieItemStack({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 16.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  image: NetworkImage(
                      "https://image.tmdb.org/t/p/w200/" + movie.backdropPath!),
                  fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              alignment: Alignment.center,
              width: 45.0,
              height: 45.0,
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFF99F00), Color(0xFFDB3069)]),
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
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  movie.title?.toUpperCase() ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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
