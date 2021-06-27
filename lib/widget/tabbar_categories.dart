import 'package:flutter/material.dart';
import 'package:movieapp/data/remote/model/categories.dart';
import 'package:movieapp/utils/constans.dart';

class TabbarCategoriesWidget extends StatefulWidget {
  final Function(Category) onCategoryChange;
  const TabbarCategoriesWidget({Key key, this.onCategoryChange})
      : super(key: key);

  @override
  _TabbarCategoriesWidgetState createState() => _TabbarCategoriesWidgetState();
}

class _TabbarCategoriesWidgetState extends State<TabbarCategoriesWidget> {
  int _positionSelectTab = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      height: 60,
      child: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (item, index) {
          return _buildItemTabBar(context, index);
        },
        itemCount: listCategory.length,
      ),
    );
  }

  Widget _buildItemTabBar(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (_positionSelectTab != index) {
              _positionSelectTab = index;
              widget.onCategoryChange(listCategory[index]);
            }
          });
          print("on Tab");
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              listCategory[index].name,
              style: Theme.of(context).textTheme.headline5.copyWith(
                  fontWeight: FontWeight.w600,
                  color: index == _positionSelectTab
                      ? Colors.black
                      : Colors.black.withOpacity(0.4)),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              height: 6,
              width: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: index == _positionSelectTab
                    ? Colors.red
                    : Colors.transparent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
