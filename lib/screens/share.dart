import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget/button.dart';
import '../src/authentication.dart';

class Share extends StatefulWidget {
  Share({Key? key}) : super(key: key);

  @override
  _ShareState createState() => _ShareState();
}

class _ShareState extends State<Share> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
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
              'SHARE THE APP',
              style: Theme.of(context).textTheme.headline1,
            ),
          )
        ],
      ),
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
            }),
    );
  }

  Widget buildShareButton(BuildContext context) {
    var button = createButton(
        onPressed: () {
          debugPrint('TODO: HAVE A SHAREABLE LINK FOR EMAIL/SOCIAL MEDIA');
        },
        child: Text('Share the App'),
        context: context);
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: button,
    );
  }

  Widget BuildCopyButton(BuildContext context) {
    var button = createButton(
        onPressed: () {
          debugPrint('TODO: COPY TO CLIPBOARD');
        },
        child: Text('Share the App'),
        context: context);

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: button,
    );
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
            GestureDetector(
                onTap: () {
                  debugPrint('popping');
                  Navigator.pop(context);
                },
                child: buildTitle(context)),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLink(context),
                    buildShareButton(context),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
