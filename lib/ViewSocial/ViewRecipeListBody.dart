import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharecipe/ViewSocial/ViewRecipeListTile.dart';
import 'package:sharecipe/models/recipe.dart';
import 'package:sharecipe/shared/loading.dart';

class UserRecipeListSocial extends StatefulWidget {
  UserRecipeListSocial({this.uid});
  String uid;
  @override
  _UserRecipeListSocialState createState() => _UserRecipeListSocialState();
}

class _UserRecipeListSocialState extends State<UserRecipeListSocial> {
  bool loading = true;
  Recipes recipe;
  
  @override
  Widget build(BuildContext context) {
    final recipesList = Provider.of<List<Recipes>>(context);
    try {
      recipesList.length;
    } catch (e) {
      return Loading();
    }
    if (recipesList.length == 0) {
      return Center(
        child: Text("User hasn't published any recipes yet.",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      );
    } else
      return ListView.builder(
          itemCount: recipesList.length,
          itemBuilder: (context, index) {
            return UserRecipeTileSocial(userRecipe: recipesList[index]);
          },
        );
  }

}
