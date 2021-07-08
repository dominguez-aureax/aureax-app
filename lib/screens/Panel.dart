import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/button.dart';
import '../widget/card.dart';

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

  Widget buildBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitleBar(),
          buildData(),
        ],
      ),
    );
  }

  Padding buildTitleBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          createImage(),
          createText(),
          createMenu(),
        ],
      ),
    );
  }

  Container createImage() {
    return Container(
      width: 80,
      height: 80,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: Image.network('assets/loading.gif'),
    );
  }

  Padding createText() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            '${context.read<AuthenticationService>().getUser()}',
            style: Theme.of(context).textTheme.headline1,
          ),
          Text(
            'Admin/Title',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }

  Widget createMenu() {
    return Expanded(
      child: Align(
        alignment: Alignment(0, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Icon(Icons.menu,
                  color: Theme.of(context).primaryColor, size: 50),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildData() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            createCard(
                icon: Icon(Icons.people,
                    color: Theme.of(context).primaryColor, size: 80),
                text: Text('Members',
                    style: Theme.of(context).textTheme.bodyText1)),
            createCard(
              icon: Icon(Icons.person_add,
                  color: Theme.of(context).primaryColor, size: 80),
              text: Text('Referrals',
                  style: Theme.of(context).textTheme.bodyText1),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            createCard(
              icon: Icon(Icons.library_add,
                  color: Theme.of(context).primaryColor, size: 80),
              text: Text('Edit Jobs',
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            createCard(
              icon: Icon(Icons.star_border,
                  color: Theme.of(context).primaryColor, size: 80),
              text: Text('Edit Campaigns',
                  style: Theme.of(context).textTheme.bodyText1),
            )
          ],
        )
      ],
    );
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
