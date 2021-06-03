// Libraries
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Screens
import 'package:aureax_app/screens/Login.dart';
import 'package:aureax_app/screens/SignUp.dart';

void main() {
  runApp(MaterialApp(
    title: 'Aureax',
    initialRoute: '/',
    routes: {
      '/': (context) => Login(),
      '/signup': (context) => SignUp(),
    },
    theme: ThemeData(
      // Define the default brightness and colors
      brightness: Brightness.dark,
      backgroundColor: const Color(0xFF232931),
      primaryColor: const Color(0xFFeeeeee),
      accentColor: const Color(0xFF46aff0),
      fontFamily: GoogleFonts.roboto().fontFamily,
      textTheme:TextTheme(
        headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
        subtitle1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
      ),
    ),
  ));
}