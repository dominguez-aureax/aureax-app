import 'dart:async';
import 'package:aureax_app/screens/member_data.dart';
import 'package:aureax_app/screens/splash_screen.dart';
import 'package:aureax_app/src/dynamic_link_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../screens/referral.dart';

import '../widget/auth_nav.dart';
import '../widget/login_nav.dart';

import './database.dart';

class Authentication extends StatelessWidget {
  Widget initApp(context) {
    return MaterialApp(
        title: 'Aureax',
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (context) => AuthenticationWrapper(),
          '/loading': (context) => SplashScreen(),
          '/login': (context) => LoginNav(),
          '/auth': (context) => AuthNav(),
          '/referral': (context) => Referral(),
          '/member_data': (context) => MemberData(),
        },
        theme: ThemeData(
            brightness: Brightness.dark,
            backgroundColor: const Color(0xFF232931),
            primaryColor: const Color(0xFFeeeeee),
            accentColor: const Color(0xFF45aff0),
            fontFamily: GoogleFonts.roboto().fontFamily,
            textTheme: TextTheme(
              headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
              subtitle1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              bodyText1:
                  TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider<AuthenticationService>(
        create: (_) => AuthenticationService(FirebaseAuth.instance),
      ),
      StreamProvider(
        create: (context) =>
            context.read<AuthenticationService>().authStateChanges,
        initialData: null,
      ),
    ], child: initApp(context));
  }
}

// Authentication Wrapper which will handle loading the login credentials.
//
// While the credentials are loading there will be a splash screen displayed
class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  State createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper>
    with WidgetsBindingObserver {
  final DynamicLinkService _dynamicLinkService = DynamicLinkService();
  Timer? _timerLink;

  @override
  void initState() {
    // display the build
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    initDynamicLinks();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await _dynamicLinkService.handleDynamicLinks(context);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    if (_timerLink != null) {
      _timerLink!.cancel();
    }
    super.dispose();
  }

  // Check for dynamic link calls
  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      var deepLink = dynamicLink?.link;

      if (deepLink != null) {
        debugPrint('AUTHENTICATION STATE --- A DYNAMIC LINK WAS DETECTED');
        await Navigator.pushReplacementNamed(
          context,
          '/referral',
        );
      }
    }, onError: (OnLinkErrorException e) async {
      debugPrint(
          'AUTHENTICATION STATE --- AN ERROR HAS OCCURRED WITH A DYNAMIC LINK');
      debugPrint(e.message);
    });

    var data = await FirebaseDynamicLinks.instance.getInitialLink();
    var deepLink = data?.link;

    if (deepLink != null) {
      debugPrint('AUTHENTICATION STATE --- A DYNAMIC LINK OPENED THIS APP!');
      await Navigator.pushNamed(context, '/referral');
    }

    debugPrint('AUTHENTICATION STATE --- A DYNAMIC LINK WAS NOT FOUND');
  }

  @override
  Widget build(BuildContext context) {
    var firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return AuthNav();
    }

    return LoginNav();
  }
}

// Authentication Service used for login/signup.
class AuthenticationService {
  // Entry point of Firebase Authentication SDK
  final FirebaseAuth _firebaseAuth;
  // Referance to FireStore database
  final DatabaseReference db = DatabaseReference();
  //  Unique Dynamic Link
  String? linkMessage;
  // Dynamic Link Service
  final DynamicLinkService _dynamicLinkService = DynamicLinkService();

  // Constructor
  AuthenticationService(this._firebaseAuth) {
    if (_firebaseAuth.currentUser != null) {
      initDynamicLink();
    }
  }

  // Bind user to follow when authenticationh state changes.
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // get the current user's name
  String? getUser() {
    return _firebaseAuth.currentUser!.displayName;
  }

  String? getID() {
    return _firebaseAuth.currentUser!.uid;
  }

  // initialize the basic dynamic link
  Future<void> initDynamicLink() async {
    var uri = await getLink();
    linkMessage = uri.toString();
  }

  Future<Uri> getLink() async {
    // Get current user
    var user = _firebaseAuth.currentUser;
    // Get Uid
    var uid = user!.uid;

    return await _dynamicLinkService.createReferralLink(uid);
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
    debugPrint('AUTHENTICAITON SERVICE --- ATTEMPTING TO SIGN OUT...');
    await FirebaseAuth.instance.signOut();
    debugPrint('AUTHENTICATION SERVICE --- SIGN OUT COMPLETE.');
  }
}
