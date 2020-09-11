import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharecipe/services/database.dart';
import 'dart:async';
import 'package:sharecipe/shared/loading.dart';

class UserProfileBodyNew extends StatefulWidget {
  UserProfileBodyNew({this.uid});
  String uid;
  @override
  _UserProfileBodyNewState createState() => _UserProfileBodyNewState();
}

class _UserProfileBodyNewState extends State<UserProfileBodyNew> {
  
  String _name;
  int _recipes;
  String _photoURL;


  @override
  void initState() {
    super.initState();
    DatabaseService(uid: widget.uid).getData().then((value){
      setState(() {
        _name = value.data["name"];
        _photoURL = value.data["photoURL"];
        _recipes = value.data["recipes"];
      });
    });
    
  }

  @override
  Widget build(BuildContext context) {
    if (_photoURL == null){
      return Loading();
    }
    else{
    return Container(
      padding: EdgeInsets.only(top: 50),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                _photoURL,
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(_name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Recipes Published",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
              SizedBox(
                width: 30.0,
              ),
              Text(_recipes.toString(),
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
            ],
          )
        ],
      ),
      
    );
    }
  }
}
