import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = 'Mobile_ID';

class Ads {
  BannerAd _bannerAd;
  void Initialize() {
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
  }

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

  void showBannerAd() {
    _bannerAd = createBannerAd()
      ..load()
      ..show();
  }

  void dispose() async {
    await _bannerAd.dispose();
    _bannerAd = null;
  }
}
