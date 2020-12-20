import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:sharecipe/Drawer_Pages/user_recipes/userRecipeTile.dart';
import 'package:sharecipe/models/UserData.dart';
import 'package:sharecipe/models/recipe.dart';
import 'package:sharecipe/models/users.dart';
import 'package:sharecipe/services/database.dart';
import 'package:sharecipe/shared/loading.dart';
import 'package:sharecipe/Drawer_Pages/user_drafts/draftTile.dart';
import 'package:sharecipe/Drawer_Pages/user_drafts/editDraftForm.dart';
import 'package:sharecipe/services/localDB_helper.dart';
import 'package:toast/toast.dart';

class ViewDrafts extends StatefulWidget {
  ViewDrafts({this.uid});
  String uid;
  @override
  _ViewDraftsState createState() => _ViewDraftsState();
}

class _ViewDraftsState extends State<ViewDrafts> {
  bool loading = true;

  List<Map<String,dynamic>> drafts = [];

  void getDrafts() async{
    drafts = await LocalDatabaseService.instance.queryAll();
    setState(() {
      drafts = drafts;
    });
  }

  @override
  void initState(){
    super.initState();
    getDrafts();
  }

  @override
  Widget build(BuildContext context) {
    try {
      drafts.length;
    } catch (e) {
      return Loading();
    }
    if (drafts.length == 0) {
      return Center(
        child: Text("You have no drafts as of now!",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      );
    } else
      return ListView.builder(
          itemCount: drafts.length,
          itemBuilder: (context, index) {
            return  Container(
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
                 drafts[index]["_recipeName"],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("DRAFT", style: TextStyle(color: Colors.red)),
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
                                onPressed: () async{
                                  int rows = await LocalDatabaseService.instance.delete1(drafts[index]["_id"]);
                                  getDrafts();
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
                    _showMyDialog();
                  },
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditDraftForm(authorName: drafts[index]["_authorName"],
            id : drafts[index]["_id"],
            uid: drafts[index]["_uid"],
            recipeCount: drafts[index]["_recipeCount"],
            recipeName: drafts[index]["_recipeName"],
            recipePrepTime: drafts[index]["_recipePrepTime"],
            cookingTime: drafts[index]["_cookingTime"],
            ingredients: drafts[index]["_ingredients"],
            quantity: drafts[index]["_quantity"],
            units: drafts[index]["_units"],
            steps: drafts[index]["_steps"],
            private: drafts[index]["_private"])));
                },
              ),
            ]),
          )),
    );
            /* 
            DraftTile(authorName: drafts[index]["_authorName"],
            id : drafts[index]["_id"],
            uid: drafts[index]["_uid"],
            recipeCount: drafts[index]["_recipeCount"],
            recipeName: drafts[index]["_recipeName"],
            recipePrepTime: drafts[index]["_recipePrepTime"],
            cookingTime: drafts[index]["_cookingTime"],
            ingredients: drafts[index]["_ingredients"],
            quantity: drafts[index]["_quantity"],
            units: drafts[index]["_units"],
            steps: drafts[index]["_steps"],
            private: drafts[index]["_private"])
            */
            //ListTile(
              //title: Text(drafts[index]["_recipeName"]),
              //trailing: IconButton(icon: Icon(Icons.delete),
              //onPressed: () async{
                //int rows = await LocalDatabaseService.instance.delete1(drafts[index]["_id"]);
                //print(rows);
                //getDrafts();
              //}),
            ;
          },
        );
  }
}
