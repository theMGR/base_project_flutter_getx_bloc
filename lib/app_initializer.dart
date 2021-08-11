import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:project/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/firebase_utils/firebase_utils.dart';
import 'core/local_notification_utils/local_notification_utils.dart';
import 'core/utils/permission_utils.dart';
import 'core/workmanager_utils/workmanager_utils.dart';

class AppInitializer {
  static void initFirebaseLocalNotificationWorkManagerPermission({Function(String?)? onFcmToken}) async {
    if(Foundation.kIsWeb || Platform.isAndroid || Platform.isIOS) {
      await Firebase.initializeApp();

      // Update the iOS foreground notification presentation options to allow heads up notifications.
      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    if(navigatorKey.currentState != null && navigatorKey.currentState?.context != null) {
      FirebaseUtils.initialize(context: navigatorKey.currentState!.context);
      LocalNotificationUtils.initialize(navigatorKey.currentState!.context);
      WorkManagerUtils.initialize();

      PermissionUtils.checkPermission();
    }

    if(onFcmToken != null) {
      onFcmToken(await FirebaseUtils.getFCMToken());
    }
  }

  static void clearData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();

    FirebaseUtils.deleteFCMToken();
  }

}
