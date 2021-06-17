import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../screens/login.dart';
import '../screens/panel.dart';
import '../screens/sign_up.dart';
import '../screens/referral.dart';

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
            '/referral': (context) => Referral(),
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
  void initDynamicLinks(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      var deepLink = dynamicLink?.link;

      if (deepLink != null) {
        debugPrint('A DYNAMIC LINK OPENED THIS APP!');
        await Navigator.pushNamed(context, '/referral');
      }
    }, onError: (OnLinkErrorException e) async {
      debugPrint('onLinkError: ');
      debugPrint(e.message);
    });

    var data = await FirebaseDynamicLinks.instance.getInitialLink();
    var deepLink = data?.link;

    if (deepLink != null) {
      debugPrint('A DYNAMIC LINK OPENED THIS APP!');
      await Navigator.pushNamed(context, '/referral');
    }

    debugPrint('A DYNAMIC LINK WAS NOT FOUND');
  }

  @override
  Widget build(BuildContext context) {
    initDynamicLinks(context);

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
  String? linkMessage = 'NO LINK';

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  String? getUser() {
    return _firebaseAuth.currentUser!.displayName;
  }

  Future<void> initDynamicLink() async {
    var uri = await getLink();
    debugPrint('URL: ${uri.toString()}');
    linkMessage = uri.toString();
  }

  Future<Uri> getLink() async {
    // Get current user
    var user = _firebaseAuth.currentUser;
    // Get Uid
    var uid = user!.uid;
    // Create link
    var link = '?invitedby=' + uid;
    debugPrint('link: $link');
    // Create Dynamic Link
    var params = DynamicLinkParameters(
      uriPrefix: 'https://aureaxapp.page.link',
      link: Uri.parse(link),
    );

    return await params.buildUrl();
  }

  Future<String> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      await initDynamicLink();
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
    String phone,
  ) async {
    try {
      var credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await credential.user!.updateProfile(displayName: displayName);
      var userId = credential.user!.uid;
      await db.addClient(userId, email, password, displayName, phone);
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
