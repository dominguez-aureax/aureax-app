import 'package:aureax_app/widget/app_bar.dart';
import 'package:aureax_app/widget/button.dart';
import 'package:flutter/material.dart';

const ROUTE_NAME = 'referral';

class Referral extends StatefulWidget {
  Referral({Key? key}) : super(key: key);

  @override
  _ReferralState createState() => _ReferralState();
}

class _ReferralState extends State<Referral> {
  String name = '';
  String phone = '';
  String email = '';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Widget buildBody() {
    return Scaffold(
      key: scaffoldKey,
      appBar: createAppBar(text: 'TODO: ADD DETAILS', context: context),
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
          buildTitle(),
          buildForm(),
        ],
      ),
    );
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
              'Add Referral',
              style: Theme.of(context).textTheme.headline1,
            ),
          )
        ],
      ),
    );
  }

  Widget buildForm() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildName(),
                buildPhone(),
                buildEmail(),
                buildButton(context),
              ],
            )),
      ),
    );
  }

  Widget buildName() {
    return TextFormField(
      decoration: InputDecoration(hintText: 'Jane Doe', labelText: 'Full Name'),
      validator: (String? value) {
        return (value != null && value.isNotEmpty)
            ? null
            : 'Full Name is required';
      },
      onSaved: (String? value) {
        if (value != null) {
          name = value.trim();
        }
      },
    );
  }

  Widget buildPhone() {
    return TextFormField(
        decoration:
            InputDecoration(hintText: '888-888-8888', labelText: 'PhoneNumber'),
        validator: (String? value) {
          return null;
        },
        onSaved: (String? value) {
          if (value != null) {
            phone = value.trim();
          }
        });
  }

  Widget buildButton(BuildContext context) {
    return createButton(
        onPressed: () {
          formKey.currentState!.save();
          if (!formKey.currentState!.validate()) {
            return;
          }
          Navigator.pop(context);
        },
        child: Text('Submit'),
        context: context);
  }

  Widget buildEmail() {
    return TextFormField(
        decoration: InputDecoration(
            hintText: 'example@email.com', labelText: 'Email Address'),
        validator: (String? value) {
          if (value == null || value.isEmpty || !value.contains('@')) {
            return 'Enter a valid Email Address';
          }
          return null;
        },
        onSaved: (String? value) {
          if (value != null) {
            email = value.trim();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }
}
