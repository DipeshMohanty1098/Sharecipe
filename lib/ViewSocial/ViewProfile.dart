import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharecipe/Drawer_Pages/userProfile/user_profile_body.dart';
import 'package:sharecipe/ViewSocial/ViewProfileBody.dart';
import 'package:sharecipe/models/UserData.dart';
import 'package:sharecipe/services/database.dart';

class ViewUserProfile extends StatefulWidget {
  ViewUserProfile({this.uid, this.authorName});
  String authorName;
  String uid;
  @override
  _ViewUserProfileState createState() => _ViewUserProfileState();
}

class _ViewUserProfileState extends State<ViewUserProfile> {
  @override
  Widget build(BuildContext context) {
     return WillPopScope(
        onWillPop: () {
          //dispose();
          Navigator.pop(context, (Route<dynamic> route) => false);
          //return Future.value(false);
        },
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "${widget.authorName}" + "'s" + " Profile",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              backgroundColor: Colors.white,
              elevation: 7,
            ),
            body: UserProfileBodyNew(uid: widget.uid)),
    );
  }
}