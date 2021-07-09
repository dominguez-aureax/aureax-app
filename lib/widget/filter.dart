import 'package:flutter/material.dart';

Widget createFilter({
  required bool active,
  required String text,
  required BuildContext context,
}) {
  var color = active? Theme.of(context).accentColor : Theme.of(context).accentColor.withAlpha(50);
  return Flexible(child: ElevatedButton(
    style: ButtonStyle (
      foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
      backgroundColor: MaterialStateProperty.all(color),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color:Colors.transparent),
        ),
      ),
      minimumSize: MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
      textStyle: MaterialStateProperty.all(Theme.of(context).textTheme.bodyText1)
    ),
    onPressed: () {
      debugPrint('A FILTER HAS BEEN PRESSED');
    },
    child: Flexible(child: Text(text)),
  ));
}