import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:project/core/utils/print_utils.dart';
import 'package:project/data/local/repository/locale_repository.dart';
import 'package:project/presentation/ui/config/route_config.dart';
import 'package:project/presentation/ui/config/ui_config.dart';
import 'package:project/presentation/ui/di/app_bloc_container.dart';
import 'package:project/presentation/ui/di/di_container.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'presentation/lang/translation_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DIContainer.initDI();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static String bearerToken = "";
  Locale? _locale;

  MyApp({Key? key}) : super(key: key) {
    _updateValues();
  }

  @override
  Widget build(BuildContext context) {
    GetMaterialApp getMaterialApp = GetMaterialApp(
        title: "App Main",
        theme: UIConfig.themeData(),
        getPages: RouteConfig.getPages,
        initialRoute: RouteConfig.main,
        debugShowCheckedModeBanner: false,
        locale: _locale,
        supportedLocales: TranslationService.supportedLocales,
        fallbackLocale: TranslationService.fallbackLocale,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate, // uses `flutter_localizations`
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        translations: TranslationService(),
        navigatorKey: navigatorKey,
        builder: (context, child) {
          return ResponsiveWrapper.builder(BouncingScrollWrapper.builder(context, child!),
              maxWidth: 1200,
              minWidth: 450,
              defaultScale: true,
              breakpoints: [
                ResponsiveBreakpoint.resize(450, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                ResponsiveBreakpoint.autoScale(2460, name: "4K"),
              ],
              background: Container(color: Color(0xFFF5F5F5)));
        });

    return AppBlocContainer.multiBlocProvider(child: getMaterialApp);
  }

  void _updateValues() async {
    LocaleRepository? localeRepository = Get.find<LocaleRepositoryImpl>();

    try {
      String? languageCode = await localeRepository.getLanguageCodeFromLocal();
      Print("MAIN updateValue LanguageCode $languageCode");

      if (languageCode != null) {
        _locale = Locale(languageCode);
      } else {
        bool? isSaved = await localeRepository.saveLanguageCodeToLocal(languageCode: TranslationService.deviceLocale?.languageCode ?? "en");

        if(isSaved) {
          languageCode = await localeRepository.getLanguageCodeFromLocal();
          _locale = Locale(languageCode ?? "en");
        }
      }
    } catch (e) {
      _locale = TranslationService.deviceLocale;
    }

  }
}
