import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharecipe/models/user.dart';
import 'package:sharecipe/screens/HomePageBN.dart';
import 'package:sharecipe/screens/auth/authenticate.dart';
import 'package:sharecipe/screens/auth/register.dart';
import 'package:sharecipe/screens/auth/signin.dart';
import 'package:sharecipe/screens/HomePage.dart';
import 'package:sharecipe/testing.dart/test.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return HomePageBN(); //anon: user.isAnon, uid: user.uid);
      //return Test();
    }
  }
}
