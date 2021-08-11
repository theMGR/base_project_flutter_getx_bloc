/*
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageChangeProvider with ChangeNotifier {
  Locale _currentLocale = Locale("en");
  LanguageChangeProvider({String languageCode = "en"}) {
    _currentLocale = Locale(languageCode);
  }

  Locale get currentLocale => _currentLocale;

  void changeLocale(String _locale) {
    this._currentLocale = Locale(_locale);
    notifyListeners();
  }

  void setLocale(Locale locale) {
    if (AppLocalizations.supportedLocales.contains(locale)) {
      _currentLocale = locale;
    } else {
      _currentLocale = Locale("en");
    }

    notifyListeners();
  }
}
*/
