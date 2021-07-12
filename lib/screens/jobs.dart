import 'package:flutter/material.dart';

import '../widget/post.dart';

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
          buildFilters(),
          buildLists(),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Postings',
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      ),
    );
  }

  Widget buildFilters() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('TODO: ADD FILTERS')],
    );
  }

  Widget buildLists() {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        buildCard(),
        buildCard(),
        buildCard(),
      ],
    );
  }

  Widget buildCard() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 10, 10),
      child: Container(
        width: double.infinity,
        height: 140,
        decoration: BoxDecoration(color: Color(0xFF232931)),
        child: createPost(
            title: 'Manager - Business Dev',
            price: '60,000 Anually',
            location: 'Charlotte, NC',
            link: 'Link to Job',
            context: context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }
}
