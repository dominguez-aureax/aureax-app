import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {

  Scaffold initScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'images/loading.gif',
              height: 125.0,
              width: 125.0,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Text(
                'Loading...',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ]
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context)
    );
  }
}