import 'package:project/core/utils/usecase.dart';
import 'package:project/domain/entities/sample_quotable.dart';
import 'package:project/domain/repositories/sample_quotable_repository.dart';

class SampleQuotableUseCase implements UseCase<SampleQuotable?, SampleQuotableParams> {
  final SampleQuotableRepository sampleQuotableRepository;

  SampleQuotableUseCase({required this.sampleQuotableRepository});

  @override
  Future<SampleQuotable?> call(SampleQuotableParams params) async {
    return await sampleQuotableRepository.getQuotableList(page: params.page, limit: params.limit);
  }
}

class SampleQuotableParams {
  final int? page;
  final int? limit;

  SampleQuotableParams({this.page, this.limit});
}
