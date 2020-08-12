import 'package:flutter/material.dart';
import 'package:sharecipe/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:sharecipe/shared/loading.dart';

class SignInGoogle extends StatefulWidget {
  final Function toggleView;
  SignInGoogle({this.toggleView});

  @override
  _SignInGoogleState createState() => _SignInGoogleState();
}

class _SignInGoogleState extends State<SignInGoogle> {
  final AuthService _auth = AuthService();
  bool loading = false;

  String spaceremove(String email1) {
    String spaceremoved = '';
    if (email1.endsWith(' ') || email1.endsWith('\t')) {
      spaceremoved = email1.substring(0, email1.length - 1);
      return spaceremoved;
    }
    return spaceremoved;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Sign In to Sharecipe",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Center(
                      child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      Image.asset(
                        'lib/assets/logo.png',
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                      SizedBox(height: 20.0),
                      Text("Welcome to Sharecipe!",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 23.0)),
                      SizedBox(height: 40.0),
                      SizedBox(height: 0.0),
                      Container(
                        height: 55,
                        child: RaisedButton(
                            onPressed: () async {
                              setState(() => loading = true);
                              dynamic result = await _auth.googleSignIn();
                              if (result != null) {
                                print(result);
                              }
                            },
                            color: Colors.white,
                            elevation: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Sign In with Google",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0)),
                                SizedBox(
                                  width: 15,
                                ),
                                Image.asset(
                                  'lib/assets/googleLogo.png',
                                  height: 25,
                                  width: 25,
                                )
                              ],
                            )),
                      ),
                      SizedBox(height: 12.0),
                    ],
                  ))
                  /*
              child: RaisedButton(
                child: Text("Sign In as Guest"),
                onPressed: () async {
                  dynamic result = await _auth.signAnon();
                  if (result == null) {
                    print("error");
                  } else
                    print('signed in');
                  print(result.uid);
                  print(result.isAnon);
                },
              ),
              */
                  ),
            ),
          );
  }
}
