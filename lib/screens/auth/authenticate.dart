import 'package:flutter/material.dart';
import 'package:sharecipe/screens/auth/register.dart';
import 'package:sharecipe/screens/auth/signin.dart';
import 'package:sharecipe/screens/auth/signinOnlygoogle.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignInGoogle(toggleView: toggleView);
    } else
      return Register(toggleView: toggleView);
  }
}
