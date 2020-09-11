import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharecipe/ViewRecipeNew/ViewRecipe.dart';
import 'package:sharecipe/models/UserData.dart';
import 'package:sharecipe/models/recipe.dart';
import 'package:sharecipe/models/users.dart';
import 'package:sharecipe/screens/ViewRecipe.dart';
import 'package:sharecipe/services/database.dart';
import 'package:toast/toast.dart';

class UserRecipeTileSocial extends StatelessWidget {
  final Recipes userRecipe;
  UserRecipeTileSocial({this.userRecipe});

  String nameGetter(String recipeName) {
    int i = recipeName.indexOf('.');
    return recipeName.substring(0, i);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 8.0, 0, 0),
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
      child: Card(
          elevation: 7.0,
          child: Container(
            height: 100.0,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              ListTile(
                //leading: Icon(Icons.portrait),
                title: Text(
                  nameGetter(userRecipe.recipeName),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TopNav(recipe: userRecipe)));
                },
              ),
            ]),
          )),
    );
  }
}
