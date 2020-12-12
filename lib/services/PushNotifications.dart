import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
 

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future initialise() async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
      //called when app is in the foreground and then a notification pops up
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      //called when the app is closed completely and it's opened
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      //when in background and opened through the notification
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }
}
