import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'en.dart';
import 'ta.dart';

class TranslationService extends Translations {
  static Locale? get deviceLocale => Locale(Get.deviceLocale?.languageCode ?? "en");

  static String getLanguage(String code) {
    switch (code) {
      case 'ta':
        return 'தமிழ்';
      case 'hi':
        return 'हिंदी';
      case 'te':
        return 'తెలుగు';
      case 'kn':
        return 'ಕನ್ನಡ';
      case 'ml':
        return 'മലയാളം';
      case 'en':
      default:
        return 'English';
    }
  }

  static List<Locale> supportedLocales = [Locale("en"), Locale("ta")];
  static final fallbackLocale = Locale("en");

  static List<String> listLanguageCodes() {
    List<String> list = [];
    for (Locale locale in supportedLocales) {
      list.add(locale.languageCode);
    }

    return list;
  }

  @override
  Map<String, Map<String, String>> get keys => {
        "en": english,
        "ta": tamil,
      };
}
