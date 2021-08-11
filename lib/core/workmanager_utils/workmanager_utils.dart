import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart' as Foundation;
import 'package:project/core/utils/print_utils.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerUtils {
  static const String simpleTaskKey = "simpleTask";
  static const String rescheduledTaskKey = "rescheduledTask";

  WorkManagerUtils.initialize() {
/*    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      Workmanager().initialize(
        callbackDispatcher,
        isInDebugMode: false,
      );
      Print.Success("Work Manger initialize called");
    }*/
  }

  static void registerTask(
    final String taskName, {
    final ExistingWorkPolicy? existingWorkPolicy,
    final Duration initialDelay = const Duration(seconds: 0),
    final Constraints? constraints,
    final BackoffPolicy? backoffPolicy,
    final Duration backoffPolicyDelay = const Duration(seconds: 0),
    final Map<String, dynamic>? inputData,
  }) {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      Workmanager().registerOneOffTask(taskName, taskName,
          tag: taskName,
          existingWorkPolicy: existingWorkPolicy,
          backoffPolicy: backoffPolicy,
          backoffPolicyDelay: backoffPolicyDelay,
          constraints: constraints,
          initialDelay: initialDelay,
          inputData: inputData);
    }
  }

  static void registerPeriodicTask(final String taskName,
      {final Duration? frequency,
      final ExistingWorkPolicy? existingWorkPolicy,
      final Duration initialDelay = const Duration(seconds: 0),
      final Constraints? constraints,
      final BackoffPolicy? backoffPolicy,
      final Duration backoffPolicyDelay = const Duration(seconds: 0),
      final Map<String, dynamic>? inputData}) {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      Workmanager().registerPeriodicTask(taskName, taskName,
          tag: taskName,
          frequency: frequency,
          inputData: inputData,
          initialDelay: initialDelay,
          constraints: constraints,
          backoffPolicyDelay: backoffPolicyDelay,
          backoffPolicy: backoffPolicy,
          existingWorkPolicy: existingWorkPolicy);
    }
  }

  Future<bool> cancelAllTasks() async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      try {
        await Workmanager().cancelAll();
        return true;
      } catch (e) {
        Print.Error("WORK MANAGER: [cancelAllTasks()]: Exception $e");
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> cancelTaskByTag(String tag) async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      try {
        await Workmanager().cancelByTag(tag);
        return true;
      } catch (e) {
        Print.Error("WORK MANAGER: [cancelTaskByTag($tag)]: Exception $e");
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> cancelTaskByUniqueName(String uniqueName) async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      try {
        await Workmanager().cancelByUniqueName(uniqueName);
        return true;
      } catch (e) {
        Print.Error("WORK MANAGER: [cancelTaskByUniqueName($uniqueName)]: Exception $e");
        return false;
      }
    } else {
      return false;
    }
  }
}
