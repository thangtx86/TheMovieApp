import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movieapp/base/base_state.dart';
import 'package:movieapp/router/router_config.dart';
import 'package:movieapp/screens/home/home_bloc.dart';
import 'package:movieapp/data/remote/model/movie.dart';
import 'package:movieapp/utils/constans.dart';
import 'package:movieapp/utils/dimens.dart';
import 'package:movieapp/widget/button_common.dart';
import 'package:movieapp/widget/error_loading.dart';
import 'package:movieapp/widget/widget_common/dialog_widget.dart';
import 'package:provider/provider.dart';

class MovieViewPagerWidget extends StatefulWidget {
  @override
  _MovieViewPagerWidgetState createState() => _MovieViewPagerWidgetState();
}

class _MovieViewPagerWidgetState extends State<MovieViewPagerWidget> {
  PageController? pageController;

  double viewportFraction = 0.8;

  double pageOffset = 0;

  late HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = context.read<HomeBloc>();
    super.initState();

    pageController =
        PageController(initialPage: 1, viewportFraction: viewportFraction)
          ..addListener(() {
            setState(() {
              pageOffset = pageController?.page ?? 0;
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
      height: (MediaQuery.of(context).size.height / 1.6),
      child: StreamBuilder<BaseState>(
          stream: _homeBloc.moviesByCategory,
          builder: (context, AsyncSnapshot<BaseState> snapshot) {
            if (snapshot.hasData) {
              BaseState state = snapshot.data!;
              return _buildViewPageWidget(state);
            } else {
              return ErrorLoading(
                message: "Fetch data not handle..",
                height: m150Size,
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
            height: m15Size,
          ),
          ButtonCustomWidget(
            title: "View All",
            onClick: onNavigatorScreen,
          ),
          Flexible(child: _buildSliderWidget(movies, size))
        ],
      );
    } else {
      return Container();
    }
  }

  void onNavigatorScreen() {
    Navigator.pushNamed(context, RouteConfig.SHOW_ALL,
        arguments: _homeBloc.currentCategory);
  }

  Widget _buildSliderWidget(List<Movie> movies, Size size) {
    return PageView.builder(
        controller: pageController,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Container(
            width: size.width,
            padding: EdgeInsets.only(
              right: m20Size,
              left: m20Size,
              top: m30Size,
              bottom: m20Size,
            ),
            child: Column(
              children: <Widget>[
                Flexible(
                  child: Container(
                    height: m450Size,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(m50Size),
                      ),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            IMAGE_PATH_LARGE + movies[index].posterPath!),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: m10Size),
                Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: m16Size),
                    child: Text(
                      movies[index].title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          height: 1.4,
                          color: Colors.black,
                          fontSize: m28Size,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: m12Size),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RatingBar.builder(
                      itemSize: m16Size,
                      initialRating: (movies[index].voteAverage ?? 0) / 2,
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
                      movies[index].voteAverage.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: m16Size,
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
