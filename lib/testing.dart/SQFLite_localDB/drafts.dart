import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharecipe/Drawer_Pages/user_recipes/UserListRecipeBody.dart';
import 'package:sharecipe/models/UserData.dart';
import 'package:sharecipe/models/recipe.dart';
import 'package:sharecipe/models/user.dart';
import 'package:sharecipe/services/database.dart';
import 'package:sharecipe/testing.dart/SQFLite_localDB/viewDrafts.dart';

class Drafts extends StatefulWidget {
  @override
  _DraftsState createState() => _DraftsState();
}

class _DraftsState extends State<Drafts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          body: ViewDrafts(),
        );
  }
}
