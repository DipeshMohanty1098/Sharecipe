import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharecipe/Drawer_Pages/user_recipes/UserListRecipeBody.dart';
import 'package:sharecipe/ViewSocial/ViewRecipeListBody.dart';
import 'package:sharecipe/models/recipe.dart';
import 'package:sharecipe/services/database.dart';

class UserRecipesSocial extends StatefulWidget {
  UserRecipesSocial({this.uid});
  String uid;
  @override
  _UserRecipesSocialState createState() => _UserRecipesSocialState();
}

class _UserRecipesSocialState extends State<UserRecipesSocial> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Recipes>>.value(
          value: DatabaseService(uid: widget.uid).socialRecipes,
          child: Scaffold(
              appBar: AppBar(
                //iconTheme: new IconThemeData(color: Colors.black),
                elevation: 7,
                title: Text(
                  "Your Recipes",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
              ),
              body: UserRecipeListSocial(uid: widget.uid),
            ),
    );
  }
}
