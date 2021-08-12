import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/core/local_notification_utils/local_notification_utils.dart';
import 'package:project/core/utils/print_utils.dart';
import 'package:project/data/local/repository/notification_local_repository.dart';
import 'package:project/data/local/repository/sample_quotable_local_repository.dart';
import 'package:project/data/remote/model/notification_local_dto.dart';
import 'package:project/data/remote/model/sample_dto.dart';

class FirebaseUtils {
  static void initialize({required BuildContext context}) async {
    if (!Foundation.kIsWeb) {
      NotificationLocalRepository? notificationLocalRepository = Get.find<NotificationLocalRepositoryImpl>();//GetIt.I<NotificationLocalRepository>();

      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized || settings.authorizationStatus == AuthorizationStatus.provisional) {
        // Update the iOS foreground notification presentation options to allow heads up notifications.
        await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );

        //gives you the message on when user taps ant it opened the app from the terminated state
        FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
          if (message != null) {
            Print.Reference("getInitialMessage: hashCode: ${message.hashCode}");
            Print.Reference("Data: ${message.data.toString()}");

          }
        });

        // foreground work
        FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
          if (message != null) {
            Print.Reference("onMessage: hashCode: ${message.hashCode}");
            Print.Reference("Data: ${message.data.toString()}");

            NotificationLocalDTO notificationLocalDTO = NotificationLocalDTO(
                title: message.data["title"],
                body: message.data["body"],
                notificationId: message.hashCode,
                value1: message.data["key_1"],
                value2: message.data["key_2"]);

            bool? isSaved = await notificationLocalRepository.saveNotificationLocal(notificationLocalDTO: notificationLocalDTO);
            NotificationLocalDTO?  notificationLocal = await notificationLocalRepository.getNotificationLocal(notificationId: message.hashCode);

            Print.Warning("onMessage: IsSaved: $isSaved");
            Print.Warning("onMessage: notificationLocal: (null): ${notificationLocal == null} :: (notificationId): ${notificationLocal?.notificationId}");

            if (message.notification == null && isSaved && notificationLocal != null) {
              LocalNotificationUtils.display(notificationID: message.hashCode, model: notificationLocalDTO, showProgress: true, progress: 15, maxProgress: 100, color: Colors.green);
            }

            List<NotificationLocalDTO?>? listNotificationLocal = await notificationLocalRepository.getNotificationLocalList();

            Print.Info("listNotificationLocal: count: ${listNotificationLocal?.length}");

            for(NotificationLocalDTO? dto in listNotificationLocal!) {
              Print.Reference("DTO: ${dto?.notificationId}, ${dto?.title}");
            }

            SampleQuotableDTO? sampleQuotableDTO = await SampleQuotableLocalRepositoryImpl().getSampleQuotableLocal();
            Print.Info("sample quotable inside firebase ${sampleQuotableDTO.toString()}");
          }
        });

        // when the app is in background but opened and user taps on the notification
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) async {
          if (message != null) {
            Print.Reference("onMessageOpenedApp: hashCode: ${message.hashCode}");
            Print.Reference("Data: ${message.data.toString()}");

            /*bool? isSaved = await notificationLocalRepository.saveNotificationLocal(
                notificationLocalModel: NotificationLocalModel(
                   title: message.data["title"],
              body: message.data["body"],
                    notificationId: message.hashCode,
                    value1: message.data["key_1"],
                    value2: message.data["key_2"]));

            Print.Warning("IsSaved: onMessageOpenedApp : $isSaved");*/
          }

        });

        //receive message when app is in background solution for on message
        FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      } else {
        Print.Error('FirebaseMessaging: User declined or has not accepted permission');
      }
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage? message) async {
    if (message != null) {
      Print.Reference("onBackgroundMessage: hashCode: ${message.hashCode}");
      Print.Reference("Data: ${message.data.toString()}");
      Print.Reference("(message.notification == null) -> ${message.notification == null}");
      Print.Reference("Title: ${message.notification?.title}");
      Print.Reference("Body: ${message.notification?.body}");


      NotificationLocalRepository? notificationLocalRepository = NotificationLocalRepositoryImpl();

      NotificationLocalDTO? notificationLocalDTO = NotificationLocalDTO(
          title: message.data["title"],
          body: message.data["body"],
          notificationId: message.hashCode,
          value1: message.data["key_1"],
          value2: message.data["key_2"]);
      bool? isSaved = await notificationLocalRepository.saveNotificationLocal(notificationLocalDTO: notificationLocalDTO);
      NotificationLocalDTO?  notificationLocal = await notificationLocalRepository.getNotificationLocal(notificationId: message.hashCode);

      Print.Warning("onBackgroundMessage: IsSaved: $isSaved");
      Print.Warning("onBackgroundMessage: notificationLocal: (null): ${notificationLocal == null} :: (notificationId): ${notificationLocal?.notificationId}");

      if (message.notification == null && isSaved && notificationLocal != null) {
        LocalNotificationUtils.display(notificationID: message.hashCode, model: notificationLocalDTO);
      }

      List<NotificationLocalDTO?>? listNotificationLocal = await notificationLocalRepository.getNotificationLocalList();

      Print.Info("listNotificationLocal: count: ${listNotificationLocal?.length}");

      for(NotificationLocalDTO? dto in listNotificationLocal!) {
        Print.Reference("DTO: ${dto?.notificationId}, ${dto?.title}");
      }

      SampleQuotableDTO? sampleQuotableDTO = await SampleQuotableLocalRepositoryImpl().getSampleQuotableLocal();
      Print.Info("sample quotable inside firebase ${sampleQuotableDTO.toString()}");
    }
  }

  static Future<bool> deleteFCMToken() async {
    if (!Foundation.kIsWeb) {
      try {
        await FirebaseMessaging.instance.deleteToken();
        return true;
      } catch (e) {
        Print(e.toString());
        return false;
      }
    } else {
      return false;
    }
  }

  static Future<String?> getFCMToken() async {
    if (!Foundation.kIsWeb) {
      try {
        return await FirebaseMessaging.instance.getToken();
      } catch (e) {
        Print(e.toString());
        return null;
      }
    } else {
      return null;
    }
  }

}
