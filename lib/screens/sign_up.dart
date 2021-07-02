import 'package:aureax_app/src/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/button.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name = '';
  String email = '';
  String phone = '';
  String password = '';
  String passwordConfirmation = '';
  bool? acceptTerms;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget buildName() {
    return TextFormField(
        decoration:
            InputDecoration(hintText: 'Jane Doe', labelText: 'Full Name'),
        validator: (String? value) {
          return (value != null && value.isNotEmpty)
              ? null
              : 'Full Name is required';
        },
        onSaved: (String? value) {
          if (value != null) {
            name = value.trim();
          }
        });
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

  Widget buildPhone() {
    return TextFormField(
      decoration:
          InputDecoration(hintText: '888-888-8888', labelText: 'Phone Number'),
      validator: (String? value) {
        // This is not a required field
        return null;
      },
      onSaved: (String? value) {
        if (value != null) {
          phone = value.trim();
        }
      },
    );
  }

  Widget buildPassword() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Password',
        labelText: 'Password',
      ),
      validator: (String? value) {
        if (value != null) {
          if (value.length < 6) {
            return 'Password must be at least 6 characters long';
          }
          return null;
        }
        return 'Password is Required';
      },
      onSaved: (String? value) {
        if (value != null) {
          password = value.trim();
        }
      },
    );
  }

  Widget buildConfirmPassword() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Password',
        labelText: 'Confirm Password',
      ),
      validator: (String? value) {
        if (value != null) {
          if (value.compareTo(password) != 0) {
            debugPrint('password - $password');
            debugPrint('confirmPassword - $value');
            return 'Passwords must match';
          }
          if (value.length < 6) {
            return 'Password must be at least 6 characters long';
          }
          return null;
        }
        return 'Password is Required';
      },
    );
  }

  Widget buildButton(BuildContext context) {
    return createButton(
      onPressed: () {
        formKey.currentState!.save();
        if (!formKey.currentState!.validate()) {
          debugPrint('DID NOT VALIDATE');
          return;
        }

        debugPrint('VALIDATED!');

        debugPrint('Full Name --- $name');
        debugPrint('Email --- $email');
        debugPrint('Phone --- $phone');
        debugPrint('Password --- $password');

        context
            .read<AuthenticationService>()
            .signUp(email, password, name, phone);

        Navigator.pop(context);
      },
      child: Text('Sign Up'),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                                debugPrint('HomePage router');
                                Navigator.pushNamed(context, '/');
                              },
                              child: Text(
                                'Sign Up',
                                style: Theme.of(context).textTheme.headline1,
                              ))),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: SingleChildScrollView(
                      child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              buildName(),
                              buildEmail(),
                              buildPhone(),
                              buildPassword(),
                              buildConfirmPassword(),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child: buildButton(context),
                              ),
                            ],
                          )),
                    ))
              ],
            )));
  }
}
