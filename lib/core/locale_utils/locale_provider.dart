/*
import 'package:base_proj/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

AppLocalizations? getString(BuildContext context) {
  return AppLocalizations.of(context);
}

Locale? getLocale(BuildContext context) {
  return Localizations.localeOf(context);
}

String? getLanguageCode(BuildContext context) {
  return getLocale(context)?.languageCode;
}


class LocaleProvider extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
*/
