import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharecipe/Drawer_Pages/userProfile/user_profile_body.dart';
import 'package:sharecipe/models/UserData.dart';
import 'package:sharecipe/models/ads.dart';
import 'package:sharecipe/models/user.dart';
import 'package:sharecipe/services/database.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  BannerAd _bannerAd;
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Food'],
  );

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        size: AdSize.banner,
        targetingInfo: targetingInfo,
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
    final user = Provider.of<User>(context);
    return StreamProvider<UserData>.value(
      value: DatabaseService(uid: user.uid).userdata,
      child: WillPopScope(
        onWillPop: () {
          //dispose();
          Navigator.pop(context, (Route<dynamic> route) => false);
          //return Future.value(false);
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "${user.name}" + "'s" + " Profile",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              backgroundColor: Colors.white,
              elevation: 7,
            ),
            body: UserProfileBody()),
      ),
    );
  }
}
