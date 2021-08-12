import 'package:project/core/utils/mapper.dart';
import 'package:project/domain/entities/sample_quotable.dart';
import 'package:project/presentation/model/sample_quotable_model.dart';

class SampleQuotableModelMapper extends Mapper<SampleQuotableModel, SampleQuotable> {
  final SampleQuotableResultsModelMapper sampleQuotableResultsModelMapper;

  SampleQuotableModelMapper(this.sampleQuotableResultsModelMapper);

  @override
  SampleQuotableModel? reverse(SampleQuotable? input) {
    SampleQuotableModel out = SampleQuotableModel(
        count: input?.count,
        page: input?.page,
        results: sampleQuotableResultsModelMapper.reverseList(inList: input?.results),
        totalCount: input?.totalCount,
        totalPages: input?.totalPages);

    return out;
  }

  @override
  SampleQuotable? transform(SampleQuotableModel? input) {
    SampleQuotable out = SampleQuotable(
        count: input?.count,
        page: input?.page,
        results: sampleQuotableResultsModelMapper.transformList(inList: input?.results),
        totalCount: input?.totalCount,
        totalPages: input?.totalPages);

    return out;
  }
}

class SampleQuotableResultsModelMapper extends Mapper<SampleQuotableModelResults, SampleQuotableResults> {
  SampleQuotableResultsModelMapper();
  @override
  SampleQuotableModelResults? reverse(SampleQuotableResults? input) {
    SampleQuotableModelResults out = SampleQuotableModelResults(
        author: input?.author,
        authorSlug: input?.authorSlug,
        content: input?.content,
        dateAdded: input?.dateAdded,
        dateModified: input?.dateModified,
        id: input?.id,
        length: input?.length);

    return out;
  }

  @override
  SampleQuotableResults? transform(SampleQuotableModelResults? input) {
    SampleQuotableResults out = SampleQuotableResults(
        author: input?.author,
        authorSlug: input?.authorSlug,
        content: input?.content,
        dateAdded: input?.dateAdded,
        dateModified: input?.dateModified,
        id: input?.id,
        length: input?.length);

    return out;
  }
}
