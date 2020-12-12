import 'package:flutter/material.dart';


class PreviewRecipe extends StatefulWidget {
  @override
  List<String> steps;
  List<String> ingredients;
  List<String> quantity;
  List<String> units;
  String recipeName;
  String recipePrepTime;
  String cookingTime;
  PreviewRecipe({this.steps, this.ingredients,
  this.quantity, this.units, this.recipeName,
  this.recipePrepTime, this.cookingTime});
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
                  ],
                ),
              ),
            ],
          ),
    )
    );
  }
}