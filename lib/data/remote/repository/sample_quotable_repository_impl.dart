
import 'package:project/data/remote/api/rest_api_client.dart';
import 'package:project/data/remote/mapper/sample_quotable_dto_mapper.dart';
import 'package:project/domain/entities/sample_quotable.dart';
import 'package:project/domain/repositories/sample_quotable_repository.dart';

class SampleQuotableRepositoryImpl implements SampleQuotableRepository {
  final RestApiClient api;
  final SampleQuotableDTOMapper sampleQuotableDTOMapper;

  SampleQuotableRepositoryImpl({required this.api, required this.sampleQuotableDTOMapper});

  @override
  Future<SampleQuotable?> getQuotableList({int? page, int? limit}) async {
    return sampleQuotableDTOMapper.transform(await api.getQuotableList(page, limit));
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
