/*
import 'package:base_proj/bloc/home_screen/home_screen_bloc.dart';
import 'package:base_proj/bloc/login_screen/login_screen_bloc.dart';
import 'package:base_proj/bloc/splash_screen/splash_screen_bloc.dart';
import 'package:base_proj/core/network/custom_dio.dart';
import 'package:base_proj/data/local/repository/locale_repository.dart';
import 'package:base_proj/data/local/repository/notification_local_repository.dart';
import 'package:base_proj/data/local/repository/sample_quotable_local_repository.dart';
import 'package:base_proj/data/remote/api/rest_api_client.dart';
import 'package:base_proj/data/remote/repository/sample_repository.dart';
import 'package:base_proj/res/strings/app_strings/app_strings.dart';
import 'package:get_it/get_it.dart';

//sl - service locator
final sl = GetIt.instance;

Future<void> init() async {
  //core network custom dio
  sl.registerLazySingleton(() => CustomDio());

  // data remote rest api
  sl.registerLazySingleton(() => RestApiClient(sl(), baseUrl: AppStrings.get()?.BASE_URL));

  // data remote mapper
  //sl.registerLazySingleton(() => NotificationLocalMapper());

  // data local repositories
  sl.registerLazySingleton<SampleQuotableLocalRepository>(() => SampleQuotableLocalRepositoryImpl());
  sl.registerLazySingleton<LocaleRepository>(() => LocaleRepositoryImpl());
  sl.registerLazySingleton<NotificationLocalRepository>(() => NotificationLocalRepositoryImpl());

  // data remote repositories
  sl.registerLazySingleton<SampleRepository>(() => SampleRepositoryImpl(api: sl()));

  // Bloc
  // splash screen bloc
  sl.registerFactory(
    () => SplashScreenBloc(),
  );

  // login screen bloc
  sl.registerFactory(
    () => LoginScreenBloc(sampleRepository: sl(), sampleQuotableLocalRepository: sl()),
  );

  // home screen bloc
  sl.registerFactory(
    () => HomeScreenBloc(),
  );
}
*/
