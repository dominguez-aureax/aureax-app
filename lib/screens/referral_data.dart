import 'package:aureax_app/widget/app_bar.dart';
import 'package:flutter/material.dart';

class ReferralData extends StatefulWidget {
  ReferralData({Key? key}): super(key: key);

  @override
  _ReferralDataState createState() => _ReferralDataState();
}

class _ReferralDataState extends State<ReferralData> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Widget buildBody() {
    return Scaffold(
      key: scaffoldKey,
      appBar: createAppBar(text: 'PANEL - REFERRALS', context: context),
      body: buildContainer(),
    );
  }

  Widget buildContainer() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, child: buildTable(),
          )
        ],
      ),
    );
  }

  Widget buildTable() {
    return DataTable(
      columns: buildColumns(), 
      rows: buildRows(),
    );
  }

  List<DataColumn> buildColumns() {
    return <DataColumn>[
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('Email')),
      DataColumn(label: Text('Phone')),
    ];
  }

  List<DataRow> buildRows() {
    return <DataRow>[
      DataRow(cells: <DataCell>[
        DataCell(Text('Guy Buddy')),
        DataCell(Text('guy@not.an.email.com')),
        DataCell(Text('100-123-1239')),
      ]),
      DataRow(cells: <DataCell>[
        DataCell(Text('Cameron Alexander')),
        DataCell(Text('away@email.com')),
        DataCell(Text('134-2143-1235')),
      ]),
      DataRow(cells: <DataCell>[
        DataCell(Text('Darius White')),
        DataCell(Text('emailing@google.com')),
        DataCell(Text('195-923-2345')),
      ])
    ];
  }

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }
} 