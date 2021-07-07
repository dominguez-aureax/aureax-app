import 'package:aureax_app/screens/sign_up.dart';
import 'package:aureax_app/screens/login.dart';

import 'package:flutter/material.dart';

class LoginNav extends StatefulWidget {
  LoginNav({Key? key}) : super(key: key);

  @override
  _LoginNavState createState() => _LoginNavState();
}

class _LoginNavState extends State<LoginNav> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var selectedIndex = 0;

  Widget buildNav() {
    void _onItemTapped(int index) {
      setState(() {
        debugPrint('LOGIN NAV --- $index');
        selectedIndex = index;
      });
    }

    return BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Login'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Sign Up'),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    var _pages = <Widget>[
      Login(),
      SignUp(),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      body: _pages.elementAt(selectedIndex),
      bottomNavigationBar: buildNav(),
    );
  }
}
