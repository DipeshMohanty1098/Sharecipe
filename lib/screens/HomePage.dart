import 'package:flutter/material.dart';
import 'package:sharecipe/drawer.dart';
import 'package:sharecipe/models/recipe.dart';
import 'package:sharecipe/models/user.dart';
import 'package:sharecipe/models/users.dart';
import 'package:sharecipe/screens/HomePageBody.dart';
import 'package:sharecipe/screens/RecipeForm/recipe_form.dart';
import 'package:sharecipe/services/auth.dart';
import 'package:sharecipe/services/database.dart';
import 'package:provider/provider.dart';
import 'package:sharecipe/testing.dart/search_test.dart';

class HomePage extends StatefulWidget {
  //bool anon;
  //HomePage({this.anon, this.uid});
  //String uid;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void printUID(uid) {
    print(uid);
  }

  @override
  void iniState() {
    super.initState();
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamProvider<List<Recipes>>.value(
      value: DatabaseService().recipes,
      child: Scaffold(
          appBar: AppBar(
            iconTheme: new IconThemeData(color: Colors.black),
            elevation: 7,
            title: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: (MediaQuery.of(context).size.width / 4) - 28),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'lib/assets/logo.png',
                    height: 45.0,
                    width: 45.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(0.0),
                    child: Text(
                      "Sharecipe",
                      style: TextStyle(
                          fontFamily: 'Lobster',
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            centerTitle: false,
            backgroundColor: Colors.white,
          ),
          drawer: DrawerPage(),
          body: RecipeList(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.grey,
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () async {
              printUID(user.uid);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SearchRecipe())); //uid: user.uid)));
            },
          )),
    );
  }
}
