import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/button.dart';
import '../src/authentication.dart';

const ROUTE_NAME = '/panel';

class Panel extends StatefulWidget {
  Panel({Key? key}) : super(key: key);

  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  //TODO: ADD DATA TABLES

  Widget buildBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle(context),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'USER: ${context.read<AuthenticationService>().getUser()}',
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                createButton(
                  onPressed: () {
                    debugPrint('PANEL --- SIGNING OUT');
                    context.read<AuthenticationService>().signOut();
                  },
                  child: Text('Log Out'),
                  context: context
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTitle(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Text(
                  'Panel',
                  style: Theme.of(context).textTheme.headline1,
                ),
              )
            ]));
  }

  Widget buildLink(BuildContext context) {
    var uri = context.read<AuthenticationService>().linkMessage;
    return RichText(
        text: TextSpan(
      text: 'LINK: $uri',
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          debugPrint('CLICKED LINK...');
          launch('$uri');
        },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }
}
