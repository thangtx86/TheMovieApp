import 'package:flutter/material.dart';
import 'package:movieapp/base/base_state.dart';
import 'package:movieapp/data/remote/model/movie.dart';
import 'package:movieapp/router/router_config.dart';
import 'package:movieapp/screens/home/home_bloc.dart';
import 'package:movieapp/utils/dimens.dart';
import 'package:movieapp/utils/utils.dart';
import 'package:movieapp/widget/button_common.dart';
import 'package:movieapp/widget/movie_item.dart';
import 'package:provider/provider.dart';

class DiscoverWidget extends StatefulWidget {
  final Function(Movie) onItemClick;
  const DiscoverWidget({Key? key, required this.onItemClick}) : super(key: key);

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
            height: m4Size,
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
                    //TODO: Handle view
                    return Container();
                  }
                } else {
                  //TODO: Handle view
                  return Container();
                }
              }),
        ],
      ),
    );
  }

  void _onNavigatorScreen() {
    logInfo("Discover", "Discover");
    Navigator.pushNamed(context, RouteConfig.SHOW_ALL,
        arguments: homeBloc.currentCategory);
  }

  Widget _buildMovieItem(List<Movie> movies) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      padding: EdgeInsets.only(left: m10Size),
      child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: m10Size),
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  top: m10Size, bottom: m10Size, right: m15Size),
              child: MovieItem(
                movie: movies[index],
                onItemClick: (movie) {
                  Navigator.pushNamed(context, RouteConfig.DETAIL,
                      arguments: movie.id);
                  logInfo("MOVIE detail: ++: ", movie.title.toString());
                },
              ),
            );
          }),
    );
  }
}
