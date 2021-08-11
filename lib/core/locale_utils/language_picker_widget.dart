import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/data/local/repository/locale_repository.dart';
import 'package:project/lang/translation_service.dart';

class LanguagePickerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LocaleRepository? localeRepository = Get.find<LocaleRepositoryImpl>();

/*    return Scaffold(
      body: DropdownButtonHideUnderline(
        child: DropdownButton(
          //value: Get.deviceLocale,
          //icon: Container(width: 12),
          items: TranslationService.supportedLocales.map(
            (locale) {
              return DropdownMenuItem(
                child: Center(
                  child: Text(
                    TranslationService.getLanguage(locale.languageCode),
                    style: TextStyle(fontSize: 32),
                  ),
                ),
                value: locale,
                onTap: () {
                  //context.read<LanguageChangeProvider>().setLocale(locale);
                },
              );
            },
          ).toList(),
*/ /*        onChanged: (Locale? locale) async {
            if (locale != null) {
              //Print("Dropdown [locale.languageCode] ${locale.languageCode}");
              if (localeRepository != null) {
                bool isSavedLanguageCodeToLocal = await localeRepository.saveLanguageCodeToLocal(languageCode: locale.languageCode);

                if (isSavedLanguageCodeToLocal) {
                  String languageCodeFromLocal =
                      (await localeRepository.getLanguageCodeFromLocal() != null) ? "${await localeRepository.getLanguageCodeFromLocal()}" : "en";

                  Get.updateLocale(Locale(languageCodeFromLocal));
                  //Print("Dropdown languageCodeFromLocal $languageCodeFromLocal");
                }
              }
            }
          },*/ /*
        ),
      ),
    );*/


    List<String> langs = ["English", "tamil"];
    return Scaffold(
        body: DropdownButton<String>(
      // icon: Icon(Icons.arrow_drop_down),
      //value: _selectedLang,
      items:langs.map((String locale) {
        return DropdownMenuItem<String>(value: locale, child: Text(locale));
      }).toList(),
      /* onChanged: (String value) {
        // updates dropdown selected value
        setState(() => _selectedLang = value);
        // gets language and changes the locale
        LocalizationService().changeLocale(value);
      },*/
    ));
  }
}
