import 'package:flutter/material.dart';

ElevatedButton createButton({
  Key? key, 
  required void Function()? onPressed, 
  required Widget? child,
  required BuildContext context,
}) {
  return ElevatedButton(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
      backgroundColor: MaterialStateProperty.all(Theme.of(context).accentColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.transparent)
        ),
      ),
      minimumSize: MaterialStateProperty.all<Size>(
        Size(double.infinity, 50)
      ),
      textStyle: MaterialStateProperty.all(Theme.of(context).textTheme.bodyText1)
    ),
    onPressed: onPressed,
    child: child,
  );
}