import 'package:flutter/material.dart';

const ROUTE_NAME = '/campaign';

class Campaign extends StatefulWidget {
  Campaign({Key? key}) : super(key: key);

  @override
  _CampaignState createState() => _CampaignState();
}

class _CampaignState extends State<Campaign> {
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
            buildTitle(),
          ],
        ));
  }

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
              'TODO: FINISH CAMPAIGN PAGE',
              style: Theme.of(context).textTheme.headline1,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }
}
