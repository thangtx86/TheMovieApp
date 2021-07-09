import 'package:flutter/material.dart';
import 'package:movieapp/utils/color.dart';
import 'package:movieapp/utils/constans.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mMainColor,
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            color: mMainColor,
            alignment: Alignment.center,
            height: 200,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(IMAGE_DUMMY),
                  maxRadius: 40,
                  minRadius: 30,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("James Mangold",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white))
              ],
            ),
          ),
          _buildItem("Home", Icons.home, () {
            Navigator.pop(context);
          }),
          _buildItem("Favorite Movies", Icons.favorite, () {
            Navigator.pop(context); // close(context);
          }),
          _buildItem("About", Icons.info, () {
            Navigator.pop(context);
          }),
          _buildItem("Logout", Icons.logout, () {
            Navigator.pop(context);
          }),
        ],
      ),
    );
  }

  Widget _buildItem(String title, IconData iconData, Function onClick) {
    return Material(
      color: mMainColor,
      child: InkWell(
        onTap: () {
          onClick();
        },
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
            children: [
              Icon(
                iconData,
                color: Colors.white,
              ),
              SizedBox(
                width: 24,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
