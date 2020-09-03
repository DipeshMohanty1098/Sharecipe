import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharecipe/screens/Wrapper.dart';
import 'package:sharecipe/services/auth.dart';
import 'package:sharecipe/testing.dart/search.dart';
import 'package:sharecipe/testing.dart/search_test.dart';
import 'package:sharecipe/testing.dart/test.dart';
import 'dart:io';
import 'models/user.dart';

void main() => runApp(
      Home(),
    );

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        //home: Wrapper(),
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Raleway'),
      ),
    );
  }
}
