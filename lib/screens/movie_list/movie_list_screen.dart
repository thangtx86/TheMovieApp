import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieapp/base/base_bloc_provider.dart';
import 'package:movieapp/base/base_state.dart';
import 'package:movieapp/data/remote/model/categories.dart';
import 'package:movieapp/data/remote/model/movie.dart';
import 'package:movieapp/di/app_module.dart';
import 'package:movieapp/router/router_config.dart';
import 'package:movieapp/screens/movie_list/movie_list_bloc.dart';
import 'package:movieapp/utils/utils.dart';
import 'package:movieapp/widget/movie_item_stack.dart';
import 'package:movieapp/widget/widget_common/dialog_widget.dart';
import 'package:provider/provider.dart';

class MovieListScreen extends StatelessWidget {
  final Category category;
  const MovieListScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseProviderBloc(
      bloc: locator<MovieListBloc>(),
      child: MovieListWidget(
        category: category,
      ),
    );
  }
}

class MovieListWidget extends StatefulWidget {
  final Category category;
  const MovieListWidget({Key? key, required this.category}) : super(key: key);

  @override
  _MovieListWidgetState createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  late MovieListBloc _movieListBloc;
  late ScrollController _controller;

  @override
  void initState() {
    logInfo("MovieListScreen", widget.category.name.toString());
    _movieListBloc = context.read<MovieListBloc>();
    _movieListBloc.fetchMovieListCateogries(widget.category);
    _controller = ScrollController();

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _movieListBloc.loadMore(widget.category);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          padding: EdgeInsets.symmetric(horizontal: 16),
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
            size: 20,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.category.name.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: StreamBuilder<BaseState>(
            stream: _movieListBloc.moviesByCategory,
            builder: (context, AsyncSnapshot<BaseState> snapshot) {
              if (snapshot.hasData) {
                BaseState? state = snapshot.data!;
                return _buildItemMovie(state);
              } else {
                return Container(
                  child: Text('Error 1'),
                );
              }
            }),
      ),
    );
  }

  Widget _buildItemMovie(BaseState state) {
    if (state is StateLoading) {
      return LoadingProgressBar();
    } else if (state is StateLoaded<List<Movie?>>) {
      List<Movie?> movies = state.value;
      return GridView.builder(
        padding: EdgeInsets.only(left: 16),
        physics: BouncingScrollPhysics(),
        itemCount: movies.length,
        controller: _controller,
        itemBuilder: (context, index) {
          return MovieItemStack(
            movie: movies[index]!,
            onItemClick: (movie) {
              Navigator.pushNamed(context, RouteConfig.DETAIL,
                  arguments: movie.id);
              logInfo("MOVIE detail: ++: ", movie.id.toString());
            },
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 7 / 9,
        ),
      );
    } else {
      return Container(child: Text("Errors 2"));
    }
  }
}
