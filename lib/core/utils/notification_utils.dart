/*

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUtils {

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  NotificationDetails _notificationDetails;

  NotificationUtils() {
    var androidInit = AndroidInitializationSettings("ic_notification");
    var iosInit = IOSInitializationSettings();
    var initSettings = InitializationSettings(android: androidInit, iOS: iosInit);

    _flutterLocalNotificationsPlugin  = FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin.initialize(initSettings);

    setNotificationChannel(_flutterLocalNotificationsPlugin);

    var androidDetails = AndroidNotificationDetails("channelId", "channelName", "channelDescription",
        importance: Importance.max,
        priority: Priority.high,
        groupKey: "groupKey");
    var iosDetails = IOSNotificationDetails();

    _notificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);
  }

  void setNotificationChannel(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    /// Create a [AndroidNotificationChannel] for heads up notifications
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  void showNotification(RemoteMessage rMessage) async{

    String _message = rMessage.data['text'];

    _flutterLocalNotificationsPlugin.show(0, "title", _message, _notificationDetails, payload: "Notification add");
  }

  void cancelAllNotification() async {
    try {
      await _flutterLocalNotificationsPlugin.cancelAll();
    } catch (e) {
      print(e.toString());
    }
  }
}

*/
