import 'package:flutter/material.dart';
import 'package:sharecipe/screens/HomePage.dart';
import 'package:sharecipe/shared/loading.dart';

class ConfirmBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            backgroundColor: Colors.white,
            title: Text(
              "Confirmation",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'lib/assets/logo.png',
                    height: (MediaQuery.of(context).size.height - 100.0) / 2,
                    width: (MediaQuery.of(context).size.width - 100.0) / 2,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Congratulations! Your recipe has been published!!" +
                          "\n" +
                          "\n" +
                          "You can view your published recipe in the Home Page or in your Profile!" +
                          "\n" +
                          "\n" +
                          "Thank you for sharing your recipe :)",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          ));
    } catch (e) {
      Loading();
    }
  }
}
