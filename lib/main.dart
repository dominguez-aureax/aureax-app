// Libraries
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
      home: Consumer<ApplicationState>(
        builder: (context, appState, _) => Authentication(
          loginState: appState.loginState,
          email: appState.email,
          startLoginFlow: appState.startLoginFlow,
          verifyEmail: appState.verifyEmail,
          signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
          cancelRegistration: appState.cancelRegistration,
          registerAccount: appState.registerAccount,
          signOut: appState.signOut,
        ),
      ),
      /*
      initialRoute: '/',
      routes: {
        '/': (context) => Consumer<ApplicationState>(
          builder :(context, appState, _) => Authentication(
            loginState: appState.loginState, 
            email: appState.email, 
            startLoginFlow: appState.startLoginFlow, 
            verifyEmail: appState.verifyEmail, 
            signInWithEmailAndPassword: appState.signInWithEmailAndPassword, 
            cancelRegistration: appState.cancelRegistration, 
            registerAccount: appState.registerAccount, 
            signOut: appState.signOut,
          )
        ),
        '/login': (context) => Login(),
        '/signup': (context) => SignUp(),
      },
      */
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
      notifyListeners();
    });
  }

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;

  String? _email;
  String? get email => _email;

  void startLoginFlow() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  void verifyEmail(
    String email,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      // TODO: confirm password for email
      var methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        _loginState = ApplicationLoginState.password;
      } else {
        _loginState = ApplicationLoginState.register;
      }
      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void cancelRegistration() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  void registerAccount(
    String email, 
    String displayName,
    String password,
    void Function(FirebaseAuthException e) errorCallback
  ) async {
    try {
      var credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
        credential.user!.updateProfile(displayName: displayName);
      addClientToAccounts(email, displayName, password);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() {
    print('Signing Out...');
    FirebaseAuth.instance.signOut();
    print('Sign Out complete!');
  }

  Future<DocumentReference> addClientToAccounts(String email, String displayName, String password) {
    if (_loginState != ApplicationLoginState.loggedIn) {
      throw Exception ('Must be logged in');
    }

    return FirebaseFirestore.instance.collection('accounts').add({
      'email': email,
      'pasword': password,
      'name': displayName,
      'dateRegistered': DateTime.now().millisecondsSinceEpoch,
      'uderId': FirebaseAuth.instance.currentUser!.uid,
    });
  }
}