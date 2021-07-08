import 'package:flutter/material.dart';

Widget createCard({
  required Icon icon,
  required Text text,
}) {
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    color: Color(0x4DDA0037),
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.fromLTRB(10, 10, 50, 0), child: icon),
        Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 20), child: text)
      ],
    ),
  );
}
