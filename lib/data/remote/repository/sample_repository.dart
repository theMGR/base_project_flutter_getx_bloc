
import 'package:project/data/remote/api/rest_api_client.dart';
import 'package:project/data/remote/model/sample_dto.dart';

abstract class SampleRepository {
  Future<SampleQuotableDTO> getQuotableList({int? page, int? limit});
}

class SampleRepositoryImpl implements SampleRepository {
  final RestApiClient api;

  SampleRepositoryImpl({required this.api});

  @override
  Future<SampleQuotableDTO> getQuotableList({int? page, int? limit}) async {
    return await api.getQuotableList(page, limit);
    /*if (await networkInfoRepository.isConnected) {
      try {
        return ApiResult.success(data: await api.getJWT(username, password));
      } catch (e) {
        return ApiResult.failure(error: AppExceptions(e));
      }
    } else {
      return ApiResult.failure(error: AppExceptions(NoNetwork()));
    }*/
  }
}
