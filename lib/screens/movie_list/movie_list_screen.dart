import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieapp/base/base_bloc_provider.dart';
import 'package:movieapp/base/base_state.dart';
import 'package:movieapp/data/remote/model/categories.dart';
import 'package:movieapp/data/remote/model/movie.dart';
import 'package:movieapp/di/app_module.dart';
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
    Size size = MediaQuery.of(context).size;
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
          return MovieItemStack(movie: movies[index]!);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 3.5 / 5),
      );
    } else {
      return Container(child: Text("Errors 2"));
    }
    //   return Container(
    //     child: Stack(
    //       children: [
    //         Container(
    //           width: size.width / 3,
    //           height: size.height / 4,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.all(
    //               Radius.circular(6.0),
    //             ),
    //             shape: BoxShape.rectangle,
    //             image: DecorationImage(
    //                 image: NetworkImage("https://image.tmdb.org/t/p/w200/" +
    //                     "/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg"),
    //                 fit: BoxFit.cover),
    //           ),
    //         ),
    //         Positioned(
    //           top: 15,
    //           right: 15,
    //           child: Container(
    //             alignment: Alignment.center,
    //             width: 45.0,
    //             height: 45.0,
    //             decoration: BoxDecoration(
    //               color: Colors.white,
    //               gradient: LinearGradient(
    //                   begin: Alignment.topLeft,
    //                   end: Alignment.bottomRight,
    //                   colors: [Color(0xFFF99F00), Color(0xFFDB3069)]),
    //               shape: BoxShape.circle,
    //             ),
    //             child: Text(
    //               "9.0",
    //               style: TextStyle(color: Colors.white),
    //             ),
    //           ),
    //         ),
    //         Positioned(
    //           bottom: 8,
    //           left: 8,
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: <Widget>[
    //               Text(
    //                 "2021",
    //                 style: TextStyle(color: Colors.white, fontSize: 16),
    //               ),
    //               Text(
    //                 "The Movie".toUpperCase(),
    //                 maxLines: 1,
    //                 overflow: TextOverflow.ellipsis,
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 16,
    //                 ),
    //               )
    //             ],
    //           ),
    //         )
    //       ],
    //     ),
    //   );
    // }
  }
}
