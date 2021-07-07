import 'package:movieapp/base/base_bloc.dart';
import 'package:movieapp/data/remote/respository/imovie_respository.dart';

class MovieDetailBloc extends BaseBloc {
  final IMovieRespository _movieRespository;
  MovieDetailBloc(this._movieRespository);
  @override
  void dispose() {
    // TODO: implement dispose
  }
}
