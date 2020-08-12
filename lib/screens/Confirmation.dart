import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sharecipe/screens/ConfirmationBody.dart';
import 'package:sharecipe/screens/HomePage.dart';
import 'package:sharecipe/screens/Wrapper.dart';
import 'package:sharecipe/shared/loading.dart';

class ConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          print(
              'Backbutton pressed (device or appbar button), do whatever you want.');

          //trigger leaving and use own data
          // Navigator.pushAndRemoveUntil(
          //  context,
          // MaterialPageRoute(builder: (context) => Wrapper()),
          // (Route<dynamic> route) => false);
          Navigator.pushNamedAndRemoveUntil(
              context, '/', (Route<dynamic> route) => false);
          //we need to return a future
          return Future.value(false);
        },
        child: ConfirmBody());
  }
}
