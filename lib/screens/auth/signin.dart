import 'package:flutter/material.dart';
import 'package:sharecipe/services/auth.dart';
import 'package:flutter/services.dart';
import 'package:sharecipe/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';

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
                  style: TextStyle(color: Colors.black)),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Center(
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20.0),
                            TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'Enter your Email'),
                                validator: (val) => val == null
                                    ? 'Please Enter a valid Email'
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    email = (val);
                                    //email = spaceremove(email);
                                  });
                                }),
                            SizedBox(height: 20.0),
                            TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'Enter your Password'),
                                validator: (val) => val.length < 6
                                    ? 'Please Enter the correct Password'
                                    : null,
                                obscureText: true,
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                }),
                            SizedBox(height: 20.0),
                            RaisedButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    print(email + "$password");
                                    setState(() => loading = true);
                                    dynamic result = await _auth.signin(
                                        spaceremove(email), password);
                                    if (result != null) {
                                      print(result.uid);
                                    }
                                    if (result == null) {
                                      setState(() {
                                        error =
                                            'could not sign in with those credentials';
                                        loading = false;
                                      });
                                      SystemChannels.textInput
                                          .invokeMethod('TextInput.hide');
                                    }
                                  }
                                },
                                color: Colors.grey,
                                child: Text("Sign In")),
                            SizedBox(height: 0.0),
                            RaisedButton(
                                onPressed: () async {
                                  print(email + "$password");
                                  setState(() => loading = true);
                                  dynamic result = await _auth.googleSignIn();
                                  if (result != null) {
                                    print(result);
                                  }
                                },
                                color: Colors.grey,
                                child: Text("Sign In with Google")),
                            RaisedButton(
                                onPressed: () async {
                                  widget.toggleView();
                                },
                                color: Colors.grey,
                                child: Text(
                                    "Don't have an Account? Register Here")),
                            SizedBox(height: 12.0),
                            Text(error, style: TextStyle(color: Colors.red))
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
            ));
  }
}
