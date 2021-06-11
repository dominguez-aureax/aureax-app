import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../screens/login.dart';
import '../screens/panel.dart';
import '../screens/sign_up.dart';

import './database.dart';

class Authentication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
          title: 'Aureax',
          initialRoute: '/',
          routes: <String, WidgetBuilder>{
            '/': (context) => AuthenticationWrapper(),
            '/login': (context) => Login(),
            '/panel': (context) => Panel(),
            '/signup': (context) => SignUp(),
          },
          theme: ThemeData(
              brightness: Brightness.dark,
              backgroundColor: const Color(0xFF232931),
              primaryColor: const Color(0xFFeeeeee),
              accentColor: const Color(0xFF45aff0),
              fontFamily: GoogleFonts.roboto().fontFamily,
              textTheme: TextTheme(
                headline1:
                    TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
                subtitle1:
                    TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                bodyText1:
                    TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
              ))),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final scaffoldKey = GlobalKey<ScaffoldState>();
    var firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return Panel();
    }
    return Login();
  }
}

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final DatabaseReference db = DatabaseReference();

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  String? getUser() {
    return _firebaseAuth.currentUser!.displayName;
  }

  Future<String> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return 'Signed In';
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return '$e.message';
    }
  }

  Future<String> signUp(
    String email,
    String password,
    String displayName,
  ) async {
    try {
      var credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await credential.user!.updateProfile(displayName: displayName);
      var userId = credential.user!.uid;
      await db.addClient(userId, email, password, displayName);
      return 'Signed Up';
    } on FirebaseAuthException catch (e) {
      return '$e.message';
    }
  }

  void signOut() async {
    debugPrint('Signing out...');
    await FirebaseAuth.instance.signOut();
    debugPrint('Sign Out Complete!!!');
  }
}
