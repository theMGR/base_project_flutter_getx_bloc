import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import 'package:project/core/utils/print_utils.dart';

import '../../main.dart';

class PermissionUtils {

  static void checkPermission() async{

    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      Map<Permission, PermissionStatus>? appPermissions = await PermissionUtils.requestAppPermission();
      if (appPermissions != null) {
        appPermissions.forEach((Permission key, PermissionStatus value) {
          Print.Info("Permission $key : $value");
          if (value == PermissionStatus.granted) {
            // do nothing
          } else {
            showAlertDialog();
          }
        });
      }
    }

  }

  static Future<bool> getAllPermissionStatusForMobile() async{

    int grantedPermission = 0;
    int totalPermission = 0;

    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      Map<Permission, PermissionStatus>? appPermissions = await PermissionUtils.requestAppPermission();
      if (appPermissions != null) {
        totalPermission = appPermissions.length;
        appPermissions.forEach((Permission key, PermissionStatus value) {
          Print.Info("Permission $key : $value");
          if (value == PermissionStatus.granted) {
            ++ grantedPermission;
          }
        });
      }
    }

    return totalPermission == grantedPermission;

  }

  static Future<Map<Permission, PermissionStatus>?> requestAppPermission() async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      List<Permission> permissions = [];
      permissions.add(Permission.camera);
      permissions.add(Permission.location);
      permissions.add(Permission.locationAlways);
      permissions.add(Permission.locationWhenInUse);
      permissions.add(Permission.mediaLibrary);
      permissions.add(Permission.phone);
      permissions.add(Permission.photos);
      permissions.add(Permission.storage);
      permissions.add(Permission.ignoreBatteryOptimizations);
      permissions.add(Permission.notification);
      permissions.add(Permission.manageExternalStorage);

      for(Permission permission in permissions) {
        await permission.request();
      }

      Map<Permission, PermissionStatus> statuses = await permissions.request();

      bool? isDenied;
      statuses.forEach((Permission key, PermissionStatus value) {
        if (value == PermissionStatus.granted) {
          // do nothing
        } else {
          isDenied = true;
        }
      });

      return statuses;
    }
  }

  static void showAlertDialog() {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      String ok = "Ok";
      String cancel = "Cancel";
      String title = "Alert";
      String content = "Click \"$ok\" to Open settings to change permission";

/*      showDialog(
        context: navigatorKey.currentState!.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                child: Text(ok),
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
              ),
              TextButton(
                child: Text(cancel),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );*/

      showCupertinoDialog(
        context: navigatorKey.currentState!.context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              CupertinoDialogAction(
                child: Text(ok),
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
              ),
              CupertinoDialogAction(
                child: Text(cancel),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
}
