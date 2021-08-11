import 'package:project/core/utils/print_utils.dart';
import 'package:project/data/remote/model/login_details_dto.dart';
import 'package:project/data/remote/model/sample_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'dart:io';

abstract class LoginDetailsLocalRepository {
  Future<bool> saveLoginDetailsToLocal({LoginDetailsDTO? loginDetailsDTO});

  Future<LoginDetailsDTO?> getLoginDetailsFromLocal();

  Future<bool> deleteLoginDetailsLocal();
}

class LoginDetailsLocalRepositoryImpl implements LoginDetailsLocalRepository {
  final String KEY = 'login_details_local_key';

  @override
  Future<bool> saveLoginDetailsToLocal({LoginDetailsDTO? loginDetailsDTO}) async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      if (loginDetailsDTO != null) {
        try {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          return await prefs.setString(KEY, loginDetailsDTO.toRawJson());
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
  Future<LoginDetailsDTO?> getLoginDetailsFromLocal() async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? json = prefs.getString(KEY);
        return json != null? LoginDetailsDTO.fromRawJson(json) : null;
      } catch (e) {
        Print.Debug("SP:Exception: getSampleQuotableLocal :-> $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<bool> deleteLoginDetailsLocal() async {
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
