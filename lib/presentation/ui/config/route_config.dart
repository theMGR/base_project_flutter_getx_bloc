import 'package:get/get.dart';
import 'package:project/presentation/ui/pages/0_bloc_example/bloc_example_page.dart';
import 'package:project/presentation/ui/pages/0_clean_architecture_example/clean_architecture_example_binding.dart';
import 'package:project/presentation/ui/pages/0_clean_architecture_example/clean_architecture_example_view.dart';
import 'package:project/presentation/ui/pages/0_example_page/example_page.dart';
import 'package:project/presentation/ui/pages/0_getx_example/get_xample/get_xample_binding.dart';
import 'package:project/presentation/ui/pages/0_getx_example/get_xample/get_xample_view.dart';
import 'package:project/presentation/ui/pages/app_main/app_main_binding.dart';
import 'package:project/presentation/ui/pages/app_main/app_main_view.dart';
import 'package:project/presentation/ui/pages/home/home_binding.dart';
import 'package:project/presentation/ui/pages/home/home_view.dart';
import 'package:project/presentation/ui/pages/language/language_view.dart';
import 'package:project/presentation/ui/pages/login/login_binding.dart';
import 'package:project/presentation/ui/pages/login/login_view.dart';
import 'package:project/presentation/ui/pages/module_lead/lead_approve_cancel/lead_approve_cancel_binding.dart';
import 'package:project/presentation/ui/pages/module_lead/lead_approve_cancel/lead_approve_cancel_view.dart';
import 'package:project/presentation/ui/pages/module_lead/lead_create_update/lead_create_update_binding.dart';
import 'package:project/presentation/ui/pages/module_lead/lead_create_update/lead_create_update_view.dart';
import 'package:project/presentation/ui/pages/module_lead/lead_list/lead_list_binding.dart';
import 'package:project/presentation/ui/pages/module_lead/lead_list/lead_list_view.dart';
import 'package:project/presentation/ui/pages/splash/splash_binding.dart';
import 'package:project/presentation/ui/pages/splash/splash_view.dart';

class RouteConfig {
  static final String main = "/";
  static final String splash = "/splash";
  static final String login = "/login";
  static final String home = "/home";
  static final String language = "/language";
  static final String enquiry = "/enquiry";
  static final String leadCreateUpdate = "/leadCreateUpdate";
  static final String leadApproveCancel = "/leadApproveCancel";

  static final List<GetPage> getPages = [
    GetPage(name: ExamplePage.route, page: () => ExamplePage()),
    GetPage(name: GetXamplePage.route, page: () => GetXamplePage(), binding: GetXampleBinding()),
    GetPage(name: BlocExamplePage.route, page: () => BlocExamplePage()),
    GetPage(name: CleanArchitectureExamplePage.route, page: () => CleanArchitectureExamplePage(), binding: CleanArchitectureExampleBinding()),

    GetPage(name: main, page: () => AppMainPage(), binding: AppMainBinding()),
    GetPage(name: splash, page: () => SplashPage(), binding: SplashBinding()),
    GetPage(name: login, page: () => LoginPage(), binding: LoginBinding()),
    GetPage(name: home, page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: language, page: () => LanguagePage()),
    GetPage(name: enquiry, page: () => LeadListPage(), binding: LeadListBinding()),
    GetPage(name: leadCreateUpdate, page: () => LeadCreateUpdatePage(), binding: LeadCreateUpdateBinding()),
    GetPage(name: leadApproveCancel, page: () => LeadApproveCancelPage(), binding: LeadApproveCancelBinding()),
  ];
}
