import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharecipe/ViewSocial/ViewProfile.dart';
import 'package:sharecipe/ViewSocial/ViewRecipeList.dart';
import 'package:sharecipe/models/recipe.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:sharecipe/models/ads.dart';

class TopNav extends StatefulWidget {
  TopNav({this.recipe});
  Recipes recipe;

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Food'],
  );

  @override
  _TopNavState createState() => _TopNavState();
}

class _TopNavState extends State<TopNav> {
  String nameGetter(String recipeName) {
    int i = recipeName.indexOf('.');
    return recipeName.substring(0, i);
  }

  String FirstName(String name){
    return name.substring(0,name.indexOf(' '));

  }

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: 'ca-app-pub-2352422574824794/2667820004',
        size: AdSize.banner,
        targetingInfo: TopNav.targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  String UIDgetter(String recipeName){
    return recipeName.substring(recipeName.indexOf(".")+1, recipeName.length);
  }

  void dispose() {
    //_bannerAd.dispose();
    try {
      _bannerAd?.dispose();
      _bannerAd = null;
    } catch (ex) {}
    super.dispose();
  }

  @override
  void initState() {
    FirebaseAdMob.instance
        .initialize(appId: 'ca-app-pub-2352422574824794~3350346287');
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> Bodies = [
      Container(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Text("Cooking Time",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            SizedBox(
              height: 10.0,
            ),
            Text("${widget.recipe.cookingTime}" + " Minutes",
                style: TextStyle(fontSize: 25)),
            SizedBox(
              height: 10.0,
            ),
            Text("Preparation Time",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "${widget.recipe.recipePreptime}" + " Minutes",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text("Recipe By:",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10.0,
            ),
            Text("${widget.recipe.authorName}", style: TextStyle(fontSize: 25)),
            SizedBox(height: 20.0,),
            Container(
              height: 45,
              child: FlatButton(
                color: Colors.grey,
                child: Text("View " + FirstName(widget.recipe.authorName) + "'s" + " profile", style: TextStyle(fontSize: 18) ),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ViewUserProfile(uid: UIDgetter(widget.recipe.recipeName), authorName: widget.recipe.authorName,)));
                            print((widget.recipe.uid));
                            print(widget.recipe.authorName);
                },
              ),
            ),
            SizedBox(height: 20.0,),
            Container(
              height: 45,
              child: FlatButton(
                color: Colors.grey,
                child: Text("View " + FirstName(widget.recipe.authorName) + "'s" + " other recipes", style: TextStyle(fontSize: 18) ),
                onPressed: (){
                  print((widget.recipe.uid));
                            print(widget.recipe.authorName);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UserRecipesSocial(uid: UIDgetter(widget.recipe.recipeName))));
                },
              ),
            ),
            SizedBox(height: 50)
          ],
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Center(
              child: Text(
            "${widget.recipe.ingredients}",
            style: TextStyle(fontSize: 20),
          )),
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Center(
              child: Text(
            "${widget.recipe.steps}",
            style: TextStyle(fontSize: 20),
          )),
        ),
      ),
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 7,
            title: Text(
              nameGetter(widget.recipe.recipeName),
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            bottom: TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                tabs: <Widget>[
                  Tab(
                    text: 'Information',
                  ),
                  Tab(text: 'Ingredients'),
                  Tab(text: 'Steps')
                ]),
          ),
          body: TabBarView(
            children: Bodies,
          )),
    );
  }
}
