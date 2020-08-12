import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharecipe/models/UserData.dart';
import 'package:sharecipe/models/recipe.dart';
import 'package:sharecipe/models/users.dart';
import 'package:sharecipe/screens/ViewRecipe.dart';
import 'package:sharecipe/services/database.dart';
import 'package:toast/toast.dart';

class UserRecipeTile extends StatelessWidget {
  final Recipes userRecipe;
  UserRecipeTile({this.userRecipe});

  String nameGetter(String recipeName) {
    int i = recipeName.indexOf('.');
    return recipeName.substring(0, i);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
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
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.black,
                  onPressed: () async {
                    Future<void> _showMyDialog() async {
                      return showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Are you sure?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(
                                      'Are you sure you want to delete this Recipe?'),
                                  Text('This action cannot be reversed.'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(
                                  'No, do not delete',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text(
                                  'Yes, delete this recipe',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  DatabaseService().deleteRecipefromDB(
                                      userRecipe.recipeName);
                                  DatabaseService(uid: userRecipe.uid)
                                      .reduceRecipeCount(user.recipes);
                                  Navigator.of(context).pop();
                                  Toast.show(
                                      "Recipe Succesfully deleted.", context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM,
                                      backgroundColor: Colors.grey);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }

                    ;
                    _showMyDialog();
                  },
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ViewRecipe(recipe: userRecipe)));
                },
              ),
            ]),
          )),
    );
  }
}
