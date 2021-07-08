import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieapp/utils/dimens.dart';

class ButtonCustomWidget extends StatelessWidget {
  const ButtonCustomWidget(
      {Key? key, required this.title, required this.onClick})
      : super(key: key);

  final String title;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: m8Size),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                this.onClick();
              },
              child: Text(
                "${this.title}",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: Colors.white,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  this.onClick();
                },
                child: FaIcon(
                  FontAwesomeIcons.arrowRight,
                  size: m20Size,
                  color: Colors.black.withOpacity(0.8),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}
