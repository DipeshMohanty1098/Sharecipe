import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharecipe/Drawer_Pages/userProfile/user_profile.dart';
import 'package:sharecipe/Drawer_Pages/userProfile/user_profile_body.dart';
import 'package:sharecipe/Drawer_Pages/user_recipes/UserListRecipes.dart';
import 'package:sharecipe/models/user.dart';
import 'package:sharecipe/services/auth.dart';

class DrawerPage extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Drawer(
        child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text("Welcome, ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
          accountEmail: Text("${user.name}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(user.photoURL),
          ),
        ),
        ListTile(
            title: Text("View Profile",
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserProfile()));
            }),
        ListTile(
            title: Text("My Recipes",
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserRecipes()));
            }),
        ListTile(
            title:
                Text("Sign Out", style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () async {
              Navigator.pop(context);
              await _auth.signOut();
            }),
      ],
    ));
  }
}
