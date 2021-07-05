import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieapp/base/base_state.dart';
import 'package:movieapp/data/remote/model/movie.dart';
import 'package:movieapp/screens/home/home_bloc.dart';
import 'package:movieapp/widget/button_common.dart';
import 'package:movieapp/widget/movie_item.dart';
import 'package:provider/provider.dart';

class DiscoverWidget extends StatefulWidget {
  const DiscoverWidget({Key? key}) : super(key: key);

  @override
  _DiscoverWidgetState createState() => _DiscoverWidgetState();
}

class _DiscoverWidgetState extends State<DiscoverWidget> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = context.read<HomeBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ButtonCustomWidget(title: "Discover", onClick: _onNavigatorScreen),
          SizedBox(
            height: 4.0,
          ),
          StreamBuilder<BaseState>(
              stream: homeBloc.moviesDiscover,
              builder: (context, AsyncSnapshot<BaseState> snapshot) {
                if (snapshot.hasData) {
                  BaseState state = snapshot.data!;
                  if (state is StateLoaded<List<Movie>>) {
                    List<Movie> movies = state.value;
                    return _buildMovieItem(movies);
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              }),
        ],
      ),
    );
  }

  void _onNavigatorScreen() {
    log("Discover");
  }

  Widget _buildMovieItem(List<Movie> movies) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      padding: EdgeInsets.only(left: 10.0),
      child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 10),
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15.0),
              child: MovieItem(movie: movies[index]),
            );
          }),
    );
  }
}
