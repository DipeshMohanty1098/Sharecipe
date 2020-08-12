import 'package:flutter/material.dart';
import 'package:sharecipe/models/recipe.dart';
import 'package:sharecipe/models/users.dart';
import 'package:sharecipe/screens/ViewRecipe.dart';
import 'package:sharecipe/testing.dart/test.dart';

class UserTile extends StatelessWidget {
  final Recipes user;
  UserTile({this.user});

  String nameGetter(String recipeName) {
    int i = recipeName.indexOf('.');
    return recipeName.substring(0, i);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.fromLTRB(0, 8.0, 0, 0),
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 7.0),
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          elevation: 7.0,
          child: Container(
            height: 100.0,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              ListTile(
                //leading: Image.network(
                // 'https://food.fnr.sndimg.com/content/dam/images/food/fullset/2012/11/2/0/DV1510H_fried-chicken-recipe-10_s4x3.jpg.rend.hgtvcom.616.462.suffix/1568222255998.jpeg',
                //  fit: BoxFit.cover,
                // ),
                title: Text(
                  nameGetter(user.recipeName),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("By " + "${user.authorName}"),
                trailing: Text(
                  "Time to Cook" + "\n" + "   ${user.cookingTime}" + " Mins",
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewRecipe(recipe: user)));
                },
              ),
            ]),
          )),
    );
  }
}
