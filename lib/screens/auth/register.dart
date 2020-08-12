import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:sharecipe/services/auth.dart';
import 'package:sharecipe/shared/loading.dart';
import 'failed_login.dart';
import 'package:flutter/services.dart';
import 'dart:core';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String password_confirm = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Sign Up to Sharecipe",
                  style: TextStyle(color: Colors.black)),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        TextFormField(
                            decoration:
                                InputDecoration(hintText: 'Enter Your Email'),
                            validator: (val) => val.isEmpty
                                ? 'Please Enter a valid Email'
                                : null,
                            onChanged: (val) {
                              setState(() {
                                email = val;
                              });
                            }),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Enter a Password (6 chars)'),
                          validator: (val) => val.length < 6
                              ? 'Please create a valid password with 6+ chars'
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration:
                              InputDecoration(hintText: 'Confirm Password'),
                          validator: (val) => val != password
                              ? 'Passwords do not Match!'
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() {
                              password_confirm = val;
                            });
                          },
                        ),
                        SizedBox(height: 20.0),
                        RaisedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.register(email, password);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error = 'Failed to Register';
                                    SystemChannels.textInput
                                        .invokeMethod('TextInput.hide');
                                  });
                                }
                              }
                            },
                            color: Colors.grey,
                            child: Text("Register")),
                        RaisedButton(
                            onPressed: () async {
                              widget.toggleView();
                            },
                            color: Colors.grey,
                            child:
                                Text("Already have an Account? Sign in Here")),
                        SizedBox(height: 12.0),
                        Text(error, style: TextStyle(color: Colors.red))
                      ],
                    )),
              ),
            ));
  }
}
