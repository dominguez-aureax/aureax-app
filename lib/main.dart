// Libraries
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'src/authentication.dart';

Future<void> main() async {
  // Allow widgets to be Binded
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp();
  runApp(Authentication());
}
