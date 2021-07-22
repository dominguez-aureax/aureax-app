import 'package:flutter/material.dart';

AppBar createAppBar({
  required String text,
  required BuildContext context,
}) {
  return AppBar(
    automaticallyImplyLeading: true,
    title: Text(
      text,
      style: Theme.of(context).textTheme.headline1,
    ),
    centerTitle: true,
    elevation: 4,
  );
}
