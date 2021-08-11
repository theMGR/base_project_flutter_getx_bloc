import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' as Scheduler;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project/core/utils/print_utils.dart';
import 'package:project/data/remote/model/notification_local_dto.dart';

import '../../main.dart';

class LocalNotificationUtils {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void _requestPermission(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    bool? result;

    if (Platform.isIOS) {
      result = await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isMacOS) {
      result = await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
  }

  static void initialize(BuildContext context) {
    if (!Foundation.kIsWeb) {
      AndroidInitializationSettings androidSettings = AndroidInitializationSettings("@mipmap/ic_launcher");

      Future onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
        if (payload != null && title != null && body != null) {
          Print.Success("Payload: $payload");
          // display a dialog with the notification details, tap ok to go to another page
          showDialog(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(body),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Ok'),
                  onPressed: () async {
                    Navigator.of(context, rootNavigator: true).pop();
                    // TODO
                   /* await RouteHelper.navigatorPushReplacementNamed(navigatorKey.currentContext!, RouteConstants.loginScreenRoute,
                        arguments: {HomeScreen.NOTIFICATION_ID_KEY: payload});*/
                  },
                )
              ],
            ),
          );
        }
      }

      IOSInitializationSettings iosSettings = IOSInitializationSettings(
          requestSoundPermission: true,
          requestBadgePermission: true,
          requestAlertPermission: true,
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);

      MacOSInitializationSettings macOSSettings =
          MacOSInitializationSettings(requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true);

      final InitializationSettings initializationSettings = InitializationSettings(android: androidSettings, iOS: iosSettings, macOS: macOSSettings);

      _flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? payload) async {
        if (payload != null) {
          Print.Success("Payload: $payload");

          if (navigatorKey.currentState != null) {
            // TODO
            /*Scheduler.SchedulerBinding.instance?.addPostFrameCallback((_) => RouteHelper.navigatorPushReplacementNamed(
                navigatorKey.currentContext!, RouteConstants.loginScreenRoute,
                arguments: {HomeScreen.NOTIFICATION_ID_KEY: payload}));*/
          }
        }
      });
      //_setNotificationChannel(_flutterLocalNotificationsPlugin);
    }
  }

  void _setNotificationChannel(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    /// Create a [AndroidNotificationChannel] for heads up notifications
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifi', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  }

  // largeIcon: const DrawableResourceAndroidBitmap('sample_large_icon'),
  // largeIcon: FilePathAndroidBitmap(largeIconPath),
  // largeIcon: ByteArrayAndroidBitmap.fromBase64String(largeIcon),
  // BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
  //             hideExpandedLargeIcon: true,
  //            contentTitle: 'overridden <b>big</b> content title',
  //             htmlFormatContentTitle: true,
  //             summaryText: 'summary <i>text</i>',
  //             htmlFormatSummaryText: true);

  static void display(
      {required int? notificationID,
      required NotificationLocalDTO? model,
      String channelId = "default_id",
      String channelName = "Default Notification",
      String channelDescription = "This is default notification description",
      String? icon = "@mipmap/ic_launcher",
      bool autoCancel = true,
      Color? color,
      bool showProgress = false,
      int maxProgress = 0,
      int progress = 0,
      AndroidBitmap<Object>? largeIcon = const DrawableResourceAndroidBitmap("ic_launcher_large")}) async {
    if (!Foundation.kIsWeb && notificationID != null && model != null) {
      Print("Local Notification Called");

      AndroidNotificationDetails androidDetails = AndroidNotificationDetails(channelId, channelName, channelDescription,
          importance: Importance.max,
          priority: Priority.high,
          setAsGroupSummary: true,
          autoCancel: autoCancel,
          sound: RawResourceAndroidNotificationSound("notification_alert"),
          icon: icon,
          playSound: true,
          enableVibration: true,
          channelShowBadge: true,
          color: color,
          showProgress: showProgress,
          maxProgress: maxProgress,
          progress: progress,
          largeIcon: largeIcon);

      IOSNotificationDetails iosDetails = IOSNotificationDetails(threadIdentifier: channelId);

      MacOSNotificationDetails macOSDetails = MacOSNotificationDetails(threadIdentifier: channelId);

      NotificationDetails notificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails, macOS: macOSDetails);

      final int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      await _flutterLocalNotificationsPlugin.show(notificationID, model.title, model.body, notificationDetails, payload: model.toString());
    }
  }
}

/*
========
For iOS:
========
final bool result = await flutterLocalNotificationsPlugin
    .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
    ?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
    );

==========
For macOS:
==========
final bool result = await flutterLocalNotificationsPlugin
    .resolvePlatformSpecificImplementation<
        MacOSFlutterLocalNotificationsPlugin>()
    ?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
    );


*/
