import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/base/base_bloc_provider.dart';
import 'package:movieapp/screens/home/home_bloc.dart';
import 'package:movieapp/di/app_module.dart';
import 'package:movieapp/widget/discover.dart';
import 'package:movieapp/widget/genre_movie_widget.dart';
import 'package:movieapp/widget/movie_baner_slider.dart';
import 'package:movieapp/widget/tabbar_categories.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseProviderBloc<HomeBloc>(
      bloc: locator<HomeBloc>(),
      child: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  HomeBloc _movieListBloc;

  @override
  void initState() {
    _movieListBloc = context.read<HomeBloc>();
    _movieListBloc.requestGenres();
    _movieListBloc.fetchDiscoverMovie();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBarWidget(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TabbarCategoriesWidget(
              onCategoryChange: (categories) =>
                  {_movieListBloc.onChangeCategory(categories)},
            ),
            SizedBox(
              height: 5,
            ),
            GenreMovieWidget(),
            SizedBox(
              height: 10,
            ),
            MovieViewPagerWidget(),
            SizedBox(
              height: 10,
            ),
            DiscoverWidget(),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarWidget() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      leading: Icon(
        EvaIcons.menu2Outline,
        color: Colors.black,
      ),
      actions: <Widget>[
        IconButton(
            onPressed: () {},
            icon: Icon(
              EvaIcons.searchOutline,
              color: Colors.black,
            ))
      ],
    );
  }
}
