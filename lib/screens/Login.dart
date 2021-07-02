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
  TextEditingController? emailController;
  TextEditingController? passwordController;
  bool? keepSignIn;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
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
          children: [
            Padding(
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
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: Theme.of(context).accentColor),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextFormField(
                      controller: emailController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'user@email.com',
                      ),
                    ),
                  ),
                  Text(
                    'Password',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: Theme.of(context).accentColor),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'password',
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment(1, 0),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Text(
                          'Forgot Password?',
                          textAlign: TextAlign.start,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Theme.of(context).accentColor,
                                  ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: CheckboxListTile(
                      value: keepSignIn ?? false,
                      onChanged: (newValue) =>
                          setState(() => keepSignIn = newValue),
                      title: Text(
                        'KEEP ME SIGNED IN',
                      ),
                      tileColor: Color(0x00f5f5f5),
                      activeColor: Theme.of(context).accentColor,
                      checkColor: Theme.of(context).primaryColor,
                      dense: false,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).accentColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.transparent)),
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(double.infinity, 50)),
                    textStyle: MaterialStateProperty.all(
                        Theme.of(context).textTheme.bodyText1)),
                onPressed: () {
                  debugPrint('Email: ' + emailController!.text);
                  debugPrint('Password: ' + passwordController!.text);
                  debugPrint('Sign in with Email proceeding');
                  context.read<AuthenticationService>().signIn(
                        emailController!.text,
                        passwordController!.text,
                      );
                },
                child: Text(
                  'Sign in with Email',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
              child: SignInButton(
                buttonType: ButtonType.google,
                btnText: 'Sign in with Google',
                onPressed: () {
                  debugPrint('Sign in with Google proceeding');
                },
                buttonSize: ButtonSize.medium,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  GestureDetector(
                    onTap: () {
                      debugPrint('Sign Up Screen Router');
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text(
                      'Sign Up!',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Theme.of(context).accentColor,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
