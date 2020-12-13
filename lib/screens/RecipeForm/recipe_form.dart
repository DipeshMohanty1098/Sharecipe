import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharecipe/models/UserData.dart';
import 'package:sharecipe/models/user.dart';
import 'package:sharecipe/screens/RecipeForm/recipe_form_body.dart';
import 'package:sharecipe/services/database.dart';
import 'package:sharecipe/screens/RecipeForm/Dynamic_form_fields.dart';
import 'package:sharecipe/testing.dart/SQFLite_localDB/form.dart';
import 'package:sharecipe/testing.dart/test_form.dart';

class RecipeForm extends StatefulWidget {
  //String uid = "";
  //RecipeForm({this.uid});
  @override
  _RecipeFormState createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamProvider<UserData>.value(
      value: DatabaseService(uid: user.uid).userdata,
      child: Scaffold(
        appBar: AppBar(
          elevation: 7,
          title: Text(
            "Publish a Recipe",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: DraftForm(uid: user.uid),
      ),
    );
  }
}
