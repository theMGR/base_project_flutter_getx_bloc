import 'package:project/core/utils/print_utils.dart';
import 'package:project/data/remote/model/notification_local_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'dart:io';

abstract class NotificationLocalRepository {
  Future<bool> saveNotificationLocal({required NotificationLocalDTO? notificationLocalDTO});

  Future<List<NotificationLocalDTO?>?> getNotificationLocalList();

  Future<NotificationLocalDTO?> getNotificationLocal({required int? notificationId});

  Future<bool> deleteNotificationLocal({required List<NotificationLocalDTO?>? listNotificationLocal});

  Future<bool> deleteNotificationLocalByNotificationId({required List<int?>? listNotificationId});

  Future<bool> deleteAllNotificationLocal();

  Future<bool> saveToOpenNotification({required int? notificationId});

  Future<NotificationLocalDTO?> getToOpenNotification();

  Future<bool> deleteToOpenNotification();
}

class NotificationLocalRepositoryImpl implements NotificationLocalRepository {
  final String KEY = 'local_notification_key';
  final String KEY_TO_OPEN_NOTIFICATION = 'to_open_notification_key';


  NotificationLocalRepositoryImpl();

  @override
  Future<bool> saveNotificationLocal({required NotificationLocalDTO? notificationLocalDTO}) async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      try {
        List<NotificationLocalDTO?>? listDTO = await getNotificationLocalList();
        if (listDTO == null) {
          listDTO = [];
        }


        if (notificationLocalDTO != null) {
          listDTO.add(notificationLocalDTO);

          List<String> listString = [];

          for (int i = 0; i < listDTO.length; i++) {
            listString.add(listDTO[i].toString());
          }

          SharedPreferences prefs = await SharedPreferences.getInstance();
          return prefs.setStringList(KEY, listString);
        } else {
          return false;
        }
      } catch (e) {
        Print.Debug("SP:Exception: saveNotificationLocal :-> $e");
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Future<List<NotificationLocalDTO?>?> getNotificationLocalList() async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String>? listString = prefs.getStringList(KEY);

        if (listString != null && listString.isNotEmpty) {
          List<NotificationLocalDTO?> listDTO = [];
          for (int i = 0; i < listString.length; i++) {
            listDTO.add(NotificationLocalDTO.getFromJson(listString[i]));
          }
          return listDTO;
        } else {
          return null;
        }
      } catch (e) {
        Print.Debug("SP:Exception: getNotificationLocalList :-> $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<NotificationLocalDTO?> getNotificationLocal({required int? notificationId}) async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      try {
        List<NotificationLocalDTO?>? listDTO = await getNotificationLocalList();

        NotificationLocalDTO? notificationLocal;
        if (listDTO != null && notificationId != null) {
          for (int i = 0; i < listDTO.length; i++) {
            if (listDTO[i]?.notificationId == notificationId) {
              notificationLocal = listDTO[i];
            }
          }
        }

        return notificationLocal;
      } catch (e) {
        Print.Debug("SP:Exception: getNotificationLocalList :-> $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<bool> deleteNotificationLocal({required List<NotificationLocalDTO?>? listNotificationLocal}) async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      try {
        List<NotificationLocalDTO?>? listDTO = await getNotificationLocalList();

        bool? isRemoved;

        if (listDTO != null && listDTO.isNotEmpty && listNotificationLocal != null && listNotificationLocal.isNotEmpty) {
          for (int i = 0; i < listDTO.length; i++) {
            for (NotificationLocalDTO? notificationLocal in listNotificationLocal) {
              if (listDTO[i]?.notificationId != null &&
                  notificationLocal != null &&
                  notificationLocal.notificationId != null &&
                  listDTO[i]?.notificationId == notificationLocal.notificationId) {
                listDTO.removeAt(i);
                isRemoved = true;
              }
            }
          }
        }

        if (isRemoved != null && isRemoved && listDTO != null) {
          List<String> listString = [];

          for (int i = 0; i < listDTO.length; i++) {
            listString.add(listDTO[i].toString());
          }

          SharedPreferences prefs = await SharedPreferences.getInstance();
          return prefs.setStringList(KEY, listString);
        } else {
          return false;
        }
      } catch (e) {
        Print.Debug("SP:Exception: deleteNotificationLocal :-> $e");
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> deleteNotificationLocalByNotificationId({required List<int?>? listNotificationId}) async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      try {
        List<NotificationLocalDTO?>? listDTO = await getNotificationLocalList();

        bool? isRemoved;

        if (listDTO != null && listDTO.isNotEmpty && listNotificationId != null && listNotificationId.isNotEmpty) {
          for (int i = 0; i < listDTO.length; i++) {
            for (int? notificationId in listNotificationId) {
              if (listDTO[i]?.notificationId != null && notificationId != null && listDTO[i]?.notificationId == notificationId) {
                listDTO.removeAt(i);
                isRemoved = true;
              }
            }
          }
        }

        if (isRemoved != null && isRemoved && listDTO != null) {
          List<String> listString = [];

          for (int i = 0; i < listDTO.length; i++) {
            listString.add(listDTO[i].toString());
          }

          SharedPreferences prefs = await SharedPreferences.getInstance();
          return prefs.setStringList(KEY, listString);
        } else {
          return false;
        }
      } catch (e) {
        Print.Debug("SP:Exception: deleteNotificationLocalByNotificationId :-> $e");
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Future<bool> deleteAllNotificationLocal() async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        return await prefs.remove(KEY);
      } catch (e) {
        Print.Debug("SP:Exception: deleteAllNotificationLocal :-> $e");
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> saveToOpenNotification({required int? notificationId}) async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      try {
        if (notificationId != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          return await prefs.setInt(KEY_TO_OPEN_NOTIFICATION, notificationId);
        } else {
          return false;
        }
      } catch (e) {
        Print.Debug("SP:Exception: saveToOpenNotification :-> $e");
        return false;
      }
    } else {
      return false;
    }
  }

  Future<NotificationLocalDTO?> getToOpenNotification() async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      try {
        List<NotificationLocalDTO?>? list = await getNotificationLocalList();
        NotificationLocalDTO? notificationLocal;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        int? notificationId = prefs.getInt(KEY_TO_OPEN_NOTIFICATION);

        if (list != null && notificationId != null) {
          for (int i = 0; i < list.length; i++) {
            if (list[i]?.notificationId == notificationId) {
              notificationLocal = list[i];
            }
          }
        }
        return notificationLocal;
      } catch (e) {
        Print.Debug("SP:Exception: getToOpenNotification :-> $e");
        return null;
      }
    } else {
      return null;
    }
  }

  Future<bool> deleteToOpenNotification() async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        return await prefs.remove(KEY_TO_OPEN_NOTIFICATION);
      } catch (e) {
        Print.Debug("SP:Exception: deleteToOpenNotification :-> $e");
        return false;
      }
    } else {
      return false;
    }
  }
}
