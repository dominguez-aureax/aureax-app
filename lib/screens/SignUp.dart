import 'package:aureax_app/src/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:aureax_app/widget/Button.dart';
import '../widget/ShowError.dart';

class SignUp extends StatefulWidget {
  SignUp({
    Key? key,
  }) : super(key: key);
  //SignUp({Key? key}) : super (key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController? nameController;
  TextEditingController? companyController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? passwordConfirmationController;
  bool? acceptTerms;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override 
  void initState() {
    super.initState();
    nameController = TextEditingController();
    companyController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmationController = TextEditingController();
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
                    child: GestureDetector(
                      onTap: () {
                        print('HomePage router');
                        Navigator.pushNamed(context, '/');
                      },
                      child: Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  )
                ],
              )
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Full Name(Required)',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Theme.of(context).accentColor
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextFormField(
                      controller: nameController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Jane Doe',
                      ),
                    )
                  ),
                  Text(
                    'Company',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Theme.of(context).accentColor
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextFormField(
                      controller: companyController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Company Name',
                      ),
                    )
                  ),
                  Text(
                    'Email Address (Required)',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Theme.of(context).accentColor
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextFormField(
                      controller: emailController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'example@email.com',
                      ),
                    )
                  ),
                  Text(
                    'Enter Password',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Theme.of(context).accentColor
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                    )
                  ),
                  Text(
                    'Confirm Password',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Theme.of(context).accentColor
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: TextFormField(
                      controller: passwordConfirmationController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: CheckboxListTile(
                      value: acceptTerms ?? false,
                      onChanged: (newValue) =>
                        setState(() => acceptTerms = newValue),
                      title: Row(
                        children: [
                          Text(
                            'I accept the '
                          ),
                          GestureDetector(
                            onTap: () {
                              print('TODO: link to Terms of Use');
                            },
                            child: Text(
                              'Terms of Use',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                          Text(
                            ' & '
                          ),
                          GestureDetector(
                            onTap: () {
                              print('TODO: link to Privacy Policy');
                            },
                            child: Text(
                              'Privacy Policy',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      tileColor: Color(0x00f5f5f5),
                      activeColor: Theme.of(context).accentColor,
                      checkColor: Theme.of(context).primaryColor,
                      dense: true,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: createButton(
                onPressed: () {
                  print('Full Name: ' + nameController!.text);
                  print('Company: ' + companyController!.text);
                  print('Email Address: ' + emailController!.text);
                  print('Password: ' + passwordController!.text);
                  validateRegistration();
                  print('user is registered and signed in');
                  context.read<AuthenticationService>().signUp(
                    emailController!.text, 
                    passwordController!.text, 
                    nameController!.text,
                  );
                }, 
                child: Text('Sign Up'), 
                context: context,
              ),
            ),
          ],
        )
      ),
    );
  }

  void validateRegistration () {
    if(emailController!.text != '' && nameController!.text != '' && passwordController!.text != ''){
      print('---SIGN UP---');
      print('Email - $emailController');
      print('Name - $nameController');
      print('password - $passwordController');
    } else {
      showError(context, 'A field needs to be edited', Exception());
    }
  }
}