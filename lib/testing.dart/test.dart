import 'package:flutter/material.dart';
import 'package:sharecipe/models/recipe.dart';

class ViewRecipeTest extends StatelessWidget {
  ViewRecipeTest({this.recipe});
  Recipes recipe;

  String nameGetter(String recipeName) {
    int i = recipeName.indexOf('.');
    return recipeName.substring(0, i);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          centerTitle: true,
          title: Text(
            nameGetter(recipe.recipeName),
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25.0),
          ),
          backgroundColor: Colors.white,
          pinned: true,
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
                'https://thestayathomechef.com/wp-content/uploads/2016/06/Fried-Chicken-4-1.jpg',
                fit: BoxFit.cover),
          ),
        ),
        SliverFillRemaining(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: (Radius.circular(10.0)),
                    topRight: Radius.circular((10.0)))),
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
                          child: Text("${recipe.cookingTime}" + " Minutes",
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
                          child: Text("${recipe.recipePreptime}" + " Minutes",
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
                          child: Text("${recipe.ingredients}",
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
                          child: Text("${recipe.steps}",
                              style: TextStyle(fontSize: 20.0))),
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text("Recipe By: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          Text("${recipe.authorName} ",
                              style: TextStyle(fontSize: 18.0)),
                        ],
                      ),
                      SizedBox(height: 30.0)
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
