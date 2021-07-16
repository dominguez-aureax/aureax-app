import 'package:flutter/material.dart';

SnackBar createSnackBar({
  required String text,
}) {
  return SnackBar(
    content: Text(text),
  );
}
