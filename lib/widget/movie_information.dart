import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MovieInformationWidget extends StatelessWidget {
  const MovieInformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: <Widget>[
          _buildMovieInfo(),
          SizedBox(
            height: 15.0,
          ),
          _buildDumyGenre(),
        ],
      ),
    );
  }

  Widget _buildDumyGenre() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _buildmGenreItem(),
        _buildmGenreItem(),
        _buildmGenreItem(),
      ],
    );
  }

  Widget _buildmGenreItem() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ElevatedButton(
        onPressed: () => {},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          side: BorderSide(color: Colors.grey.withOpacity(0.3)),
          primary: Colors.white,
        ),
        child: Text(
          "Active",
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  Widget _buildMovieInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  "Ford v Ferrari",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "2019",
                      style: TextStyle(color: Color(0xFF9A9BB2), fontSize: 14),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Text(
                      "PG-13",
                      style: TextStyle(color: Color(0xFF9A9BB2), fontSize: 14),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Text(
                      "2h 32 min",
                      style: TextStyle(color: Color(0xFF9A9BB2), fontSize: 14),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          width: 64,
          height: 64,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xFFFE6D8E),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: FaIcon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
