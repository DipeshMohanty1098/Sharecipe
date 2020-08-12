import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharecipe/Drawer_Pages/userProfile/user_profile_body.dart';
import 'package:sharecipe/models/UserData.dart';
import 'package:sharecipe/models/user.dart';
import 'package:sharecipe/services/database.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamProvider<UserData>.value(
      value: DatabaseService(uid: user.uid).userdata,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "${user.name}" + "'s" + " Profile",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            backgroundColor: Colors.white,
            elevation: 7,
          ),
          body: UserProfileBody()),
    );
  }
}
