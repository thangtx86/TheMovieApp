import 'package:flutter/material.dart';
import 'package:movieapp/base/base_state.dart';
import 'package:movieapp/data/remote/model/genre.dart';
import 'package:movieapp/screens/home/home_bloc.dart';
import 'package:provider/provider.dart';

class GenreMovieWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BaseState>(
        stream: context.watch<HomeBloc>().genresListStream,
        builder: (context, AsyncSnapshot<BaseState> snapshot) {
          BaseState state = snapshot.data;
          if (snapshot.hasData && state is StateLoaded<List<Genre>>) {
            List<Genre> genres = state.value;
            return Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              height: 40,
              child: ListView.builder(
                  padding: EdgeInsets.only(left: 16, bottom: 1),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: genres.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildItemGenre(state.value[index]);
                  }),
            );
          } else {
            return Container(
              child: Text('Nhu cco'),
            );
          }
        });
  }

  Widget _buildItemGenre(Genre genre) {
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
          genre.name,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
