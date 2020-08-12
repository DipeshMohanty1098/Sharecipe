import 'package:flutter/material.dart';
import 'package:sharecipe/models/ads.dart';
import 'package:sharecipe/models/recipe.dart';
import 'package:firebase_admob/firebase_admob.dart';

class ViewRecipe extends StatefulWidget {
  ViewRecipe({this.recipe});
  Recipes recipe;

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Food'],
  );

  @override
  _ViewRecipeState createState() => _ViewRecipeState();
}

class _ViewRecipeState extends State<ViewRecipe> {
  String nameGetter(String recipeName) {
    int i = recipeName.indexOf('.');
    return recipeName.substring(0, i);
  }

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        size: AdSize.banner,
        targetingInfo: ViewRecipe.targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  @override
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
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(nameGetter(widget.recipe.recipeName),
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
                        child: Text("${widget.recipe.cookingTime}" + " Minutes",
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
                            "${widget.recipe.recipePreptime}" + " Minutes",
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
                        child: Text("${widget.recipe.ingredients}",
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
                        child: Text("${widget.recipe.steps}",
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
                        Text("${widget.recipe.authorName} ",
                            style: TextStyle(fontSize: 18.0)),
                      ],
                    ),
                    SizedBox(height: 50.0)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
