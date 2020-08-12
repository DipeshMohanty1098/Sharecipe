import 'package:flutter/material.dart';
import 'package:sharecipe/screens/HomePage.dart';
import 'package:sharecipe/screens/RecipeForm/recipe_form.dart';

class HomePageBN extends StatefulWidget {
  @override
  _HomePageBNState createState() => _HomePageBNState();
}

class _HomePageBNState extends State<HomePageBN> {
  final items = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home, color: Colors.black), title: Text('Home')),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.add,
          color: Colors.black,
        ),
        title: Text('Publish Recipe')),
  ];

  final bodyList = [HomePage(), RecipeForm()];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blue[400],
            elevation: 7,
            items: items,
            currentIndex: currentIndex,
            onTap: onTap),
        body: IndexedStack(
          index: currentIndex,
          children: bodyList,
        ));
  }
}
