import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../widget/button.dart';

import '../src/authentication.dart';

const ROUTE_NAME = '/settings';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  //TODO: ADD TITLE
  //TODO: ADD SETTINGS

  Widget buildTitle() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: Text(
              'TODO: FINISH SETTINGS PAGE',
              style: Theme.of(context).textTheme.headline1,
            ),
          )
        ],
      ),
    );
  }

  Widget buildID() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
      child:
          Text('Unique ID - ${context.read<AuthenticationService>().getID()}'),
    );
  }

  Widget buildCopyLink() {
    var link = context.read<AuthenticationService>().linkMessage;
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          createButton(
            onPressed: () {
              debugPrint('SETTINGS --- COPYING UNIQUE LINK');
              debugPrint('Link copied: $link');
              Clipboard.setData(ClipboardData(text: link));
            },
            child: Text('Copy Referral Link'),
            context: context,
          ),
        ],
      ),
    );
  }

  Widget buildLogOut() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          createButton(
              onPressed: () {
                debugPrint('SETTINGS --- SIGNING OUT');
                context.read<AuthenticationService>().signOut();
              },
              child: Text('Log Out'),
              context: context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [buildTitle(), buildID(), buildCopyLink() ,buildLogOut()],
          ),
        ));
  }
}
