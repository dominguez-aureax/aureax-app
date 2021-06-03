// Libraries
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Screens
import 'screens/Login.dart';
import 'screens/SignUp.dart';

import 'src/authentication.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => App(),
    ),
  );
}
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}

// Provides change notification to its listeners.(A form of Observable)
class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseAuth auth = FirebaseAuth.instance;

    auth.userChanges().listen((user) {
      if(user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        print('USER IS CURRENTLY LOGGED IN');
      } else {
        _loginState = ApplicationLoginState.loggedOut;
        print('USER IS CURRENTLY LOGGED OUT');
      }
    });
  }

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;
}