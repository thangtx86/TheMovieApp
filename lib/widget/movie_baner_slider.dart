import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieapp/base/base_state.dart';
import 'package:movieapp/screens/home/home_bloc.dart';
import 'package:movieapp/data/remote/model/movie.dart';

import 'package:movieapp/widget/error_loading.dart';
import 'package:movieapp/widget/widget_common/dialog_widget.dart';
import 'package:provider/provider.dart';

class MovieViewPagerWidget extends StatefulWidget {
  @override
  _MovieViewPagerWidgetState createState() => _MovieViewPagerWidgetState();
}

class _MovieViewPagerWidgetState extends State<MovieViewPagerWidget> {
  List<VacationBean> _list = VacationBean.generate();

  PageController pageController;

  double viewportFraction = 0.8;

  double pageOffset = 0;

  HomeBloc _movieListBloc;

  @override
  void initState() {
    _movieListBloc = context.read<HomeBloc>();
    super.initState();

    pageController =
        PageController(initialPage: 1, viewportFraction: viewportFraction)
          ..addListener(() {
            setState(() {
              pageOffset = pageController.page;
            });
          });
  }

  @override
  dispose() {
    pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: StreamBuilder<BaseState>(
          stream: _movieListBloc.moviesByCategory,
          builder: (context, AsyncSnapshot<BaseState> snapshot) {
            if (snapshot.hasData) {
              BaseState state = snapshot.data;
              return _buildViewPageWidget(state);
            } else {
              return ErrorLoading(
                message: "Fetch data not handle..",
                height: 100.0 + 50,
              );
            }
          }),
    );
  }

  Widget _buildViewPageWidget(BaseState state) {
    Size size = MediaQuery.of(context).size;
    if (state is StateLoading) {
      return LoadingProgressBar();
    } else if (state is StateLoaded<List<Movie>>) {
      List<Movie> movies = state.value;
      return Column(
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("View All",
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          fontWeight: FontWeight.w600,
                        )),
                FaIcon(
                  FontAwesomeIcons.arrowRight,
                  size: 20,
                  color: Colors.black.withOpacity(0.8),
                )
              ],
            ),
          ),
          Expanded(child: _buildSliderWidget(movies, size))
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _buildSliderWidget(List<Movie> movies, Size size) {
    return PageView.builder(
        controller: pageController,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Container(
            width: size.width,
            padding: EdgeInsets.only(
              right: 20,
              left: 20,
              top: 30,
              bottom: 50,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  height: size.height / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://image.tmdb.org/t/p/w200/" +
                          movies[index].posterPath),
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      movies[index].title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          height: 1.4,
                          color: Colors.black,
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 13.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RatingBar.builder(
                      itemSize: 16.0,
                      initialRating: movies[index].voteCount / 2,
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
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      movies[index].voteCount.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}

class VacationBean {
  String url;
  String name;

  VacationBean(this.url, this.name);

  static List<VacationBean> generate() {
    return [
      VacationBean("assets/images/1.jpg", "Japan"),
      VacationBean("assets/images/2.jpg", "Franch"),
      VacationBean("assets/images/3.jpg", "Paris"),
      VacationBean("assets/images/4.jpg", "London"),
      VacationBean("assets/images/5.jpg", "China"),
    ];
  }
}
