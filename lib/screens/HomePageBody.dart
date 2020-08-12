import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:sharecipe/models/recipe.dart';
import 'package:sharecipe/models/users.dart';
import 'package:sharecipe/shared/loading.dart';
import 'UserTile.dart';

class RecipeList extends StatefulWidget {
  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    final recipes = Provider.of<List<Recipes>>(context);
    try {
      recipes.length;
    } catch (e) {
      return Loading();
    }
    if (recipes.length == 0 || recipes.length == null) {
      return Center(child: Text("No recipes to show now!"));
    } else
      return ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return UserTile(user: recipes[index]);
        },
      );
  }
}
