import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/lang/translation_service.dart';
import 'package:project/ui/config/ui_config.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: DropdownButton<Locale>(
          icon: Icon(Icons.language_sharp, color: Colors.deepPurple),
          iconSize: 28,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          value: Get.locale,
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (Locale? locale) {
            UIConfig.hideKeyboard(context: context);
            updateLocale(locale ?? TranslationService.fallbackLocale);
          },
          items: TranslationService.supportedLocales.map((Locale locale) {
            return DropdownMenuItem<Locale>(child: Text("${TranslationService.getLanguage(locale.languageCode)}"), value: locale);
          }).toList(),
        ),
      ),
    );

    return content;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateLocale(Locale locale) {
    Get.updateLocale(locale);
  }
}
