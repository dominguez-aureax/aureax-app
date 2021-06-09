import 'package:aureax_app/src/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/button.dart';

class Panel extends StatefulWidget {
  Panel({Key? key}) : super(key: key);

  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'USER: ${context.read<AuthenticationService>().getUser()}'
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  createButton(
                    onPressed: () {
                      context.read<AuthenticationService>().signOut();
                    }, 
                    child: Text('Log Out'), 
                    context: context
                  ),
                ],
              )
            )
          ],
        )
      )
    );
  }
}