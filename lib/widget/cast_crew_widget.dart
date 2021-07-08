import 'package:flutter/material.dart';
import 'package:movieapp/base/base_state.dart';
import 'package:movieapp/data/remote/model/cast_crew_response.dart';
import 'package:movieapp/screens/detail/movie_detail_bloc.dart';
import 'package:movieapp/utils/constans.dart';
import 'package:movieapp/utils/dimens.dart';
import 'package:provider/provider.dart';

class CatCrewWidget extends StatelessWidget {
  const CatCrewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: m25Size),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Cast & Crew",
            style: TextStyle(fontSize: m20Size),
          ),
          SizedBox(
            height: m20Size,
          ),
          StreamBuilder<BaseState>(
              stream: context.watch<MovieDetailBloc>().castCrewSubject,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  BaseState? state = snapshot.data;
                  return _buildListCast(state);
                } else {
                  return Container();
                }
              }),
        ],
      ),
    );
  }

  Widget _buildListCast(BaseState? state) {
    if (state is StateLoaded<CastCrewResponse>) {
      List<Cast>? casts = state.value.cast;
      return Container(
        height: 180,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _buildCastWidget(casts?[index]);
          },
          itemCount: casts?.length,
          padding: EdgeInsets.only(right: m25Size, bottom: m1Size),
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildCastWidget(Cast? cast) {
    return Container(
      width: m100Size,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            minRadius: m30Size,
            maxRadius: m45Size,
            backgroundImage:
                NetworkImage(IMAGE_PATH_SMALL + "${cast?.profilePath}"),
          ),
          SizedBox(
            height: m6Size,
          ),
          Text(
            "${cast?.name}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: m18Size),
          ),
          SizedBox(
            height: m8Size,
          ),
          Text(
            "${cast?.knownForDepartment}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Color(0xFF9A9BB2), fontSize: m16Size),
          ),
        ],
      ),
    );
  }
}
