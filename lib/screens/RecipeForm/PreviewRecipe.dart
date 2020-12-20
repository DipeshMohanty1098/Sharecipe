import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sharecipe/screens/Confirmation.dart';
import 'package:sharecipe/services/database.dart';
import 'package:sharecipe/services/localDB_helper.dart';


class PreviewRecipe extends StatefulWidget {
  @override
  String authorName;
  String uid;
  bool private;
  List<String> steps;
  List<String> ingredients;
  List<String> quantity;
  List<String> units;
  String recipeName;
  String recipePrepTime;
  String cookingTime;
  int recipes;
  PreviewRecipe({this.steps, this.ingredients,
  this.quantity, this.units, this.recipeName,
  this.recipePrepTime, this.cookingTime, this.private, this.authorName, this.uid,this.recipes});
  _PreviewRecipeState createState() => _PreviewRecipeState();
}

class _PreviewRecipeState extends State<PreviewRecipe> {

  String step = '';
  String ingredient = '';



  void createStep(){
    int j = 1;
    for (String i in widget.steps){
      setState(() {
        step +=j.toString() + '. ' + Capitalize(i) + '\n\n';
        
      });
    j+=1; 
    }
  }

  void createIngs(){
    for (int i=0;i<widget.ingredients.length;i++){
      setState(() {
        ingredient +=(i+1).toString() + '. ' + Capitalize(widget.ingredients[i]) + ' X ' + widget.quantity[i] + ' ' + widget.units[i] + '\n\n';
      });
    }
  }

  String Capitalize(String name) {
    return name.substring(0, 1).toUpperCase() + name.substring(1, name.length);
  }

  @override
  void initState(){
    super.initState();
    createStep();
    createIngs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text((Capitalize(widget.recipeName)),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          elevation: 7,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //Container(
                    // padding:
                    //    EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                    // child: Text("Recipe By",
                    //     style: TextStyle(
                    //        fontWeight: FontWeight.bold, fontSize: 25.0)),
                    // ),
                    //  Container(
                    //    padding:
                    //       EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    //  child: Text("${recipe.authorName}",
                    //     style: TextStyle(fontSize: 20.0))),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10.0),
                      child: Text("Cooking Time",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25.0)),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 10.0),
                        child: Text("${widget.cookingTime}" + " Minutes",
                            style: TextStyle(fontSize: 20.0))),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10.0),
                      child: Text("Preparation Time",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25.0)),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 10.0),
                        child: Text(
                            "${widget.recipePrepTime}" + " Minutes",
                            style: TextStyle(fontSize: 20.0))),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10.0),
                      child: Text("Ingredients",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25.0)),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 10.0),
                        child: Text(ingredient,
                            style: TextStyle(fontSize: 20.0))),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 20.0),
                      child: Text("Cooking Steps",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25.0)),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 10.0),
                        child: Text(step,
                            style: TextStyle(fontSize: 20.0))),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      child: RaisedButton(
                          onPressed: () async {
                            Future<void> _showMyDialog() async {
                              return showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Are You Sure?',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                              'Are you sure you want to publish your recipe?'),
                                          Text('It cannot be edited later. This recipe will be automatically be removed from your drafts.'),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text(
                                            'No, Review my recipe again',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text('Yes, publish my Recipe',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        onPressed: () async {
                                            print('confirmed');
                                            SystemChannels.textInput
                                                .invokeMethod('TextInput.hide');
                                            DatabaseService(uid: widget.uid)
                                                .addRecipetoDB(
                                                    widget.authorName,
                                                    Capitalize(widget.recipeName) +
                                                        '.' +
                                                        widget.uid,
                                                    int.parse(widget.recipePrepTime),
                                                    int.parse(widget.cookingTime),
                                                    ingredient,
                                                    step,
                                                    widget.recipeName
                                                        .substring(0, 1)
                                                        .toUpperCase(),
                                                    widget.private.toString());
                                            DatabaseService(uid: widget.uid)
                                                .updateRecipeCount(
                                                    widget.recipes);
                                            int rows = await LocalDatabaseService.instance.autoDelete(widget.recipeName);
                                            print(rows);
                                            print(widget.recipeName);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ConfirmationPage()));
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                              _showMyDialog();
                          },
                          color: Colors.grey,
                          child: Text("Publish your Recipe")),
                    ),
                  ],
                ),
              ),
            ],
          ),
    )
    );
  }
}