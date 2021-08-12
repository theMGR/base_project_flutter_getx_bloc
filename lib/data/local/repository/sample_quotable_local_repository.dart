import 'package:project/core/utils/print_utils.dart';
import 'package:project/data/remote/model/sample_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'dart:io';

abstract class SampleQuotableLocalRepository {
  Future<bool> saveSampleQuotableToLocal({SampleQuotableDTO? sampleQuotableDTO});

  Future<SampleQuotableDTO?> getSampleQuotableLocal();

  Future<bool> deleteSampleQuotableLocal();
}

class SampleQuotableLocalRepositoryImpl implements SampleQuotableLocalRepository {
  final String KEY = 'sample_quotable_local_key';

  @override
  Future<bool> saveSampleQuotableToLocal({SampleQuotableDTO? sampleQuotableDTO}) async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      if (sampleQuotableDTO != null) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          return await prefs.setString(KEY, sampleQuotableDTO.toString());
        } catch (e) {
          Print.Debug("SP:Exception: saveSampleQuotableToLocal :-> $e");
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Future<SampleQuotableDTO?> getSampleQuotableLocal() async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        return SampleQuotableDTO.getFromJson(prefs.getString(KEY));
      } catch (e) {
        Print.Debug("SP:Exception: getSampleQuotableLocal :-> $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<bool> deleteSampleQuotableLocal() async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.remove(KEY);
      } catch (e) {
        Print.Debug("SP:Exception: deleteSampleQuotableLocal :-> $e");
        return false;
      }
    } else {
      return false;
    }
  }
}
