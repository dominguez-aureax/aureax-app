import 'package:flutter/material.dart';

Widget createPost({
  required String title,
  required String price,
  required String location,
  required String link,
  required BuildContext context,
}) {
  Widget buildTitle() {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [Text(title, style: Theme.of(context).textTheme.subtitle1)],
        ));
  }

  Widget buildPrice() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Icon(
            Icons.work,
            color: Theme.of(context).primaryColor,
            size: 24,
          ),
        ),
        Text(price, style: Theme.of(context).textTheme.bodyText1),
      ],
    );
  }

  Widget buildLocation() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Icon(
            Icons.settings_outlined,
            color: Theme.of(context).primaryColor,
            size: 24,
          ),
        ),
        Text(location, style: Theme.of(context).textTheme.bodyText1)
      ],
    );
  }

  Widget buildDivider() {
    return Divider(
      indent: 20,
      endIndent: 20,
      color: Theme.of(context).primaryColor,
    );
  }

  Widget buildLink() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Icon(
            Icons.link,
            color: Theme.of(context).primaryColor,
            size: 24,
          ),
        ),
        Text(
          link,
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }

  return Column(
    mainAxisSize: MainAxisSize.max,
    children: [
      buildTitle(),
      buildPrice(),
      buildLocation(),
      buildDivider(),
      buildLink()
    ],
  );
}
