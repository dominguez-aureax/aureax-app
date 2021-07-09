import 'package:flutter/material.dart';

const ROUTE_NAME = '/jobs';

class Jobs extends StatefulWidget {
  Jobs({Key? key}) : super(key: key);

  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  Widget buildBody(context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildTitle(),
        ],
      ),
    );
  }

  //TODO: ADD LISTS

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
              'TODO: Postings',
              style: Theme.of(context).textTheme.headline1,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }
}
