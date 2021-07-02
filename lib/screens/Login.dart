import 'package:aureax_app/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';
import 'package:provider/provider.dart';

import '../src/authentication.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';
  bool? keepSignIn;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
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
              'Login',
              style: Theme.of(context).textTheme.headline1,
            ),
          )
        ],
      ),
    );
  }

  Widget buildForm() {
    var _formKey = GlobalKey<FormState>();

    return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    buildEmail(),
                    buildPassword(),
                    buildForgotPassword(),
                    buildCheckbox(),
                    buildEmailButton(context, _formKey),
                    buildGoogleButton(_formKey),
                    buildSignUp(),
                  ],
                ))));
  }

  Widget buildEmail() {
    return TextFormField(
        decoration: InputDecoration(
            hintText: 'example@email.com', labelText: 'Email Address'),
        validator: (String? value) {
          if (value == null || value.isEmpty || !value.contains('@')) {
            debugPrint('Email is not valid');
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

  Widget buildPassword() {
    return TextFormField(
        decoration: InputDecoration(
          hintText: 'Password',
          labelText: 'Password',
        ),
        obscureText: true,
        validator: (String? value) {
          if (value != null) {
            if (value.length < 6) {
              return 'Password must be at least 6 chracters long';
            }
            return null;
          }
          return 'Password is Required';
        },
        onSaved: (String? value) {
          if (value != null) {
            password = value.trim();
          }
        });
  }

  Widget buildForgotPassword() {
    return Align(
      alignment: Alignment(1, 0),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Text(
          'Forgot Password?',
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Theme.of(context).accentColor,
              ),
        ),
      ),
    );
  }

  Widget buildCheckbox() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: CheckboxListTile(
        value: keepSignIn ?? false,
        onChanged: (newValue) => setState(() => keepSignIn = newValue),
        title: Text(
          'KEEP ME SIGNED IN',
        ),
        tileColor: Color(0x00f5f5f5),
        activeColor: Theme.of(context).accentColor,
        checkColor: Theme.of(context).primaryColor,
        dense: false,
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }

  // TODO: Add Padding 20-0-20-20
  Widget buildEmailButton(BuildContext context, GlobalKey<FormState> formKey) {
    return createButton(
        onPressed: () {
          formKey.currentState!.save();
          if (!formKey.currentState!.validate()) {
            debugPrint('LOGIN FORM --- VALIDATION ERROR');
            return;
          }
          debugPrint('LOGIN FORM -- VALIDATED!');

          context.read<AuthenticationService>().signIn(email, password);
        },
        child: Text('Sign in with Email'),
        context: context);
  }

  // TODO: Add Padding 20-0-20-20
  Widget buildGoogleButton(GlobalKey formKey) {
    return SignInButton(
      buttonType: ButtonType.google,
      btnText: 'Sign in with Google',
      onPressed: () {
        debugPrint('LOGIN FORM --- SIGNING IN WITH GOOGLE');
      },
      buttonSize: ButtonSize.medium,
      width: double.infinity,
    );
  }

  Widget buildSignUp() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            GestureDetector(
                onTap: () {
                  debugPrint('Login Form --- Router to Sign Up Screen');
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: Text(
                  'Sign Up!',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Theme.of(context).accentColor),
                ))
          ],
        ));
  }

  //TODO: ADD Navigation Bar

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
          children: [
            buildTitle(),
            buildForm(),
          ],
        ),
      ),
    );
  }
}
