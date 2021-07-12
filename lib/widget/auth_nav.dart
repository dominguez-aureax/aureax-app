import 'package:aureax_app/screens/campaign.dart';
import 'package:aureax_app/screens/jobs.dart';
import 'package:aureax_app/screens/panel.dart';
import 'package:aureax_app/screens/settings.dart';

import 'package:flutter/material.dart';

class AuthNav extends StatefulWidget {
  AuthNav({Key? key}) : super(key: key);

  @override
  _AuthNavState createState() => _AuthNavState();
}

class _AuthNavState extends State<AuthNav> {
  var selectedIndex = 0;

  Widget buildNav() {
    void _onItemTapped(int index) {
      setState(() {
        debugPrint('AUTH NAV --- $index');
        selectedIndex = index;
      });
    }

    return BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings), label: 'Panel'),
          BottomNavigationBarItem(icon: Icon(Icons.paste), label: 'Jobs'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Active'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    var _pages = <Widget>[
      Panel(),
      Jobs(),
      Campaign(),
      Settings(),
    ];

    return Scaffold(
      body: _pages.elementAt(selectedIndex),
      bottomNavigationBar: buildNav(),
    );
  }
}
