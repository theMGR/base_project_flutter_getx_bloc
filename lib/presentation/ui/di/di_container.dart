import 'package:get/get.dart';
import 'package:project/core/network/custom_dio.dart'  if (dart.library.html) 'package:project/core/network/custom_dio_browser.dart';
import 'package:project/data/local/repository/locale_repository.dart';
import 'package:project/data/local/repository/login_details_local_repository.dart';
import 'package:project/data/local/repository/notification_local_repository.dart';
import 'package:project/data/remote/api/rest_api_client.dart';
import 'package:project/data/remote/repository/module_lead/module_lead_repository.dart';
import 'package:project/data/remote/repository/sample_repository.dart';
import 'package:project/presentation/res/strings/app_strings/app_strings.dart';
import 'package:project/presentation/ui/pages/0_bloc_example/example_bloc/example_bloc.dart';

class DIContainer {

  static void initDI() async{
    //api client
    RestApiClient restApiClient = Get.put<RestApiClient>(RestApiClient(CustomDio(), baseUrl: AppStrings.get()?.BASE_URL), permanent: true);

    //local repository
    Get.put(LocaleRepositoryImpl(), permanent: true);
    Get.put(NotificationLocalRepositoryImpl(), permanent: true);
    Get.put<LoginDetailsLocalRepositoryImpl>(LoginDetailsLocalRepositoryImpl(), permanent: true);

    //remote repository
    Get.put<SampleRepositoryImpl>(SampleRepositoryImpl(api: restApiClient), permanent: true);
    Get.put<ModuleLeadRepositoryImpl>(ModuleLeadRepositoryImpl(api: restApiClient), permanent: true);

    //bloc
    Get.put(ExampleBloc());

  }

}