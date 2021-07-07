import 'package:flutter/material.dart';
import 'package:movieapp/data/remote/model/categories.dart';
import 'package:movieapp/utils/dimens.dart';

class TabbarCategoriesWidget extends StatefulWidget {
  final Function(Category) onCategoryChange;
  const TabbarCategoriesWidget({Key? key, required this.onCategoryChange})
      : super(key: key);

  @override
  _TabbarCategoriesWidgetState createState() => _TabbarCategoriesWidgetState();
}

class _TabbarCategoriesWidgetState extends State<TabbarCategoriesWidget> {
  int _positionSelectTab = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: m10Size),
      height: m60Size,
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
      padding: EdgeInsets.symmetric(horizontal: m20Size),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (_positionSelectTab != index) {
              _positionSelectTab = index;
              widget.onCategoryChange(listCategory[index]);
            }
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              listCategory[index].name ?? "",
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: index == _positionSelectTab
                      ? Colors.black
                      : Colors.black.withOpacity(0.4)),
            ),
            Container(
              margin: EdgeInsets.only(top: m10Size),
              height: m6Size,
              width: m65Size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(m10Size),
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
