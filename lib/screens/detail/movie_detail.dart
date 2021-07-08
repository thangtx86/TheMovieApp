import 'package:flutter/material.dart';

import 'package:movieapp/base/base_bloc_provider.dart';
import 'package:movieapp/base/base_state.dart';
import 'package:movieapp/data/remote/model/movie_detail_response.dart';
import 'package:movieapp/di/app_module.dart';
import 'package:movieapp/screens/detail/movie_detail_bloc.dart';

import 'package:movieapp/widget/cast_crew_widget.dart';
import 'package:movieapp/widget/header_movie_detail.dart';
import 'package:movieapp/widget/movie_information.dart';
import 'package:movieapp/widget/movie_overview_widget.dart';
import 'package:movieapp/widget/widget_common/dialog_widget.dart';
import 'package:provider/provider.dart';

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
  late MovieDetailBloc _movieDetailBloc;
  @override
  void initState() {
    _movieDetailBloc = context.read<MovieDetailBloc>();
    _movieDetailBloc.fetchMovieDetail(widget.movieId);
    _movieDetailBloc.fetchCastCrew(widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: StreamBuilder<BaseState>(
          stream: _movieDetailBloc.moviesByCategory,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              BaseState? state = snapshot.data;
              return _buildDetailContent(state!);
            } else {
              return Container();
            }
          }),
    ));
  }

  Widget _buildDetailContent(BaseState state) {
    if (state is StateLoading) {
      return LoadingProgressBar();
    } else if (state is StateLoaded<MovieDetailResponse>) {
      MovieDetailResponse movie = state.value;
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            HeaderMovieDetail(
              movie: movie,
            ),
            SizedBox(
              height: 30.0,
            ),
            MovieInformationWidget(
              title: movie.title ?? "",
              releaseDate: movie.releaseDate ?? "",
              runTime: movie.runtime ?? 0,
              genres: movie.genres,
            ),
            SizedBox(
              height: 40,
            ),
            MovieOverviewWidget(movie: movie),
            SizedBox(
              height: 30,
            ),
            CatCrewWidget(),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
