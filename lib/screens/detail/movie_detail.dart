import 'package:flutter/material.dart';

import 'package:movieapp/base/base_bloc_provider.dart';
import 'package:movieapp/di/app_module.dart';
import 'package:movieapp/screens/detail/movie_detail_bloc.dart';

import 'package:movieapp/widget/cast_crew_widget.dart';
import 'package:movieapp/widget/header_movie_detail.dart';
import 'package:movieapp/widget/movie_information.dart';
import 'package:movieapp/widget/movie_overview_widget.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({Key? key, required this.movieId}) : super(key: key);
  final int movieId;

  @override
  Widget build(BuildContext context) {
    return BaseProviderBloc(
        bloc: locator<MovieDetailBloc>(),
        child: MovieDetailWidget(
          movieId: movieId,
        ));
  }
}

class MovieDetailWidget extends StatefulWidget {
  const MovieDetailWidget({Key? key, required this.movieId}) : super(key: key);
  final int movieId;

  @override
  _MovieDetailWidgetState createState() => _MovieDetailWidgetState();
}

class _MovieDetailWidgetState extends State<MovieDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          HeaderMovieDetail(),
          SizedBox(
            height: 30.0,
          ),
          MovieInformationWidget(),
          SizedBox(
            height: 40,
          ),
          MovieOverviewWidget(),
          SizedBox(
            height: 30,
          ),
          CatCrewWidget(),
        ],
      ),
    ));
  }
}
