import 'package:aureax_app/widget/app_bar.dart';
import 'package:flutter/material.dart';

class MemberData extends StatefulWidget {
  MemberData({Key? key}) : super(key: key);

  @override
  _MemberDataState createState() => _MemberDataState();
}

class _MemberDataState extends State<MemberData> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Widget buildBody() {
    return Scaffold(
      key: scaffoldKey,
      appBar: createAppBar(text: 'PANEL - MEMBERS', context: context),
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
              scrollDirection: Axis.horizontal, child: buildTable()),
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
      DataColumn(label: Text('Role')),
    ];
  }

  List<DataRow> buildRows() {
    return <DataRow>[
      DataRow(cells: <DataCell>[
        DataCell(Text('Melchor Dominguez')),
        DataCell(Text('mdmngz411@gmail.com')),
        DataCell(Text('Admin')),
      ]),
      DataRow(cells: <DataCell>[
        DataCell(Text('Jane Doe')),
        DataCell(Text('jane@fake.com')),
        DataCell(Text('Employee')),
      ]),
      DataRow(cells: <DataCell>[
        DataCell(Text('Abe Lincoln')),
        DataCell(Text('Abe@past.com')),
        DataCell(Text('Owner')),
      ])
    ];
  }

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }
}
