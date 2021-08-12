import 'dart:async';

import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:project/core/utils/print_utils.dart';

class LocationUtils {
  static StreamSubscription<LocationData>? _locationSubscription;

  static Future<bool> _checkService(Location location) async {
    bool serviceEnabled = await location.serviceEnabled();

    if (serviceEnabled) {
      return await _checkPermission(location);
    } else {
      serviceEnabled = await location.requestService();
      if (serviceEnabled) {
        return await _checkPermission(location);
      } else {
        return false;
      }
    }
  }

  static Future<bool> _checkPermission(Location location) async {
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.granted || permissionGranted == PermissionStatus.grantedLimited) {
      return true;
    } else {
      permissionGranted = await location.requestPermission();
      if (permissionGranted == PermissionStatus.granted || permissionGranted == PermissionStatus.grantedLimited) {
        return true;
      } else {
        return false;
      }
    }
  }

  static Future<void> getLocation(
      {void Function(LocationData)? onLocationData,
      bool enableBackgroundMode = false,
      String? title = "This application can always access your location. Tap to open",
      String? iconName,
      String? subtitle,
      String? description,
      Color? color = Colors.green,
      bool onTapBringToFront = true}) async {
    try {
      Location location = Location();
      if (!Foundation.kIsWeb) {
        location.enableBackgroundMode(enable: enableBackgroundMode);
        location.changeNotificationOptions(
            title: title, subtitle: subtitle, description: description, iconName: iconName, color: color, onTapBringToFront: onTapBringToFront);
      }
      if (await _checkService(location)) {
        LocationData locationData = await location.getLocation();
        if (onLocationData != null) {
          onLocationData(locationData);
        }
      } else {
        Print.Error("service not enabled [OR] Permission not granted");
      }
    } catch (e) {
      Print.Error("getLocation : Exception: $e");
    }
  }

  static Future<LocationData?> listenLocation(
      {void Function(LocationData)? onLocationData,
      void Function(String?)? onError,
      bool enableBackgroundMode = false,
      String? title = "This application can always access your location. Tap to open",
      String? iconName,
      String? subtitle,
      String? description,
      Color? color = Colors.green,
      bool onTapBringToFront = true}) async {
    try {
      Location location = Location();
      if (!Foundation.kIsWeb) {
        location.enableBackgroundMode(enable: enableBackgroundMode);
        location.changeNotificationOptions(
            title: title, subtitle: subtitle, description: description, iconName: iconName, color: color, onTapBringToFront: onTapBringToFront);
      }
      if (await _checkService(location)) {
        _locationSubscription = location.onLocationChanged.handleError((dynamic err) async {
          if (err is PlatformException) {
            if (onError != null) {
              onError("PlatformException: ${err.code}; ${err.message}");
              await _checkService(location);
            }
          }
          _locationSubscription?.cancel();
          _locationSubscription = null;
        }).listen((LocationData currentLocation) {
          if (onError != null) {
            onError(null);
          }
          if (onLocationData != null) {
            onLocationData(currentLocation);
          }
        });
      } else {
        Print.Error("service not enabled [OR] Permission not granted");
      }
    } catch (e) {
      Print.Error("getLocation : Exception: $e");
    }
  }

  static void dispose() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
  }
}
