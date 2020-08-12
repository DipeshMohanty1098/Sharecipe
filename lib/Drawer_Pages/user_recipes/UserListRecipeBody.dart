import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:sharecipe/Drawer_Pages/user_recipes/userRecipeTile.dart';
import 'package:sharecipe/models/UserData.dart';
import 'package:sharecipe/models/recipe.dart';
import 'package:sharecipe/models/users.dart';
import 'package:sharecipe/services/database.dart';
import 'package:sharecipe/shared/loading.dart';

class UserRecipeList extends StatefulWidget {
  UserRecipeList({this.uid});
  String uid;
  @override
  _UserRecipeListState createState() => _UserRecipeListState();
}

class _UserRecipeListState extends State<UserRecipeList> {
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    final recipes = Provider.of<List<Recipes>>(context);
    try {
      recipes.length;
    } catch (e) {
      return Loading();
    }
    if (recipes.length == 0) {
      return Center(
        child: Text("You have no published recipes!",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      );
    } else
      return StreamProvider<UserData>.value(
        value: DatabaseService(uid: widget.uid).userdata,
        child: ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            return UserRecipeTile(userRecipe: recipes[index]);
          },
        ),
      );
  }
}
