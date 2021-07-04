import 'package:flutter/material.dart';

Widget bottomNav({
  required String current,
}) {
  var authRoutes = ['/panel', '/jobs', '/campaign', '/settings'];
  var nonAuthRoutes = ['/login', '/signup'];

  Widget authNav(int index) {
    return BottomNavigationBar(
      currentIndex: index,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.paste), label: 'Jobs'),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Active'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }

  Widget nonAuthNav(int index) {
    return BottomNavigationBar(
      currentIndex: index,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.login), label: 'Login'),
        BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Sign Up'),
      ],
    );
  }

  Widget getNav(String current) {
    if (authRoutes.contains(current)) {
      var index = authRoutes.indexOf(current);
      return authNav(index);
    } else if (nonAuthRoutes.contains(current)) {
      var index = nonAuthRoutes.indexOf(current);
      return nonAuthNav(index);
    }
    return nonAuthNav(0);
  }

  return getNav(current);
}
