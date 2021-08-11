import 'package:project/core/utils/print_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'dart:io';

abstract class LocaleRepository {
  Future<bool> saveLanguageCodeToLocal({String languageCode = "en"});

  Future<String?> getLanguageCodeFromLocal();

  Future<bool> deleteLanguageCodeFromLocal();
}

class LocaleRepositoryImpl implements LocaleRepository {
  final String KEY = 'locale_key';

  @override
  Future<bool> saveLanguageCodeToLocal({String languageCode = "en"}) async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        return await prefs.setString(KEY, languageCode);
      } catch (e) {
        Print.Debug("SP:Exception : saveLanguageCodeToLocal :-> $e");
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Future<String?> getLanguageCodeFromLocal() async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getString(KEY);
      } catch (e) {
        Print.Debug("SP:Exception: getLanguageCodeFromLocal :-> $e");
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<bool> deleteLanguageCodeFromLocal() async {
    if (!Foundation.kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        return await prefs.remove(KEY);
      } catch (e) {
        //throw Exception();
        Print.Debug("SP:Exception: deleteLanguageCodeFromLocal :-> $e");
        return false;
      }
    } else {
      return false;
    }
  }
}
