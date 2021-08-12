import 'package:project/core/utils/mapper.dart';
import 'package:project/data/remote/model/sample_dto.dart';
import 'package:project/domain/entities/sample_quotable.dart';

class SampleQuotableDTOMapper extends Mapper<SampleQuotableDTO, SampleQuotable> {
  final SampleQuotableResultsDTOMapper sampleQuotableResultsDTOMapper;

  SampleQuotableDTOMapper(this.sampleQuotableResultsDTOMapper);

  @override
  SampleQuotableDTO? reverse(SampleQuotable? input) {
    SampleQuotableDTO out = SampleQuotableDTO(
        count: input?.count,
        page: input?.page,
        results: sampleQuotableResultsDTOMapper.reverseList(inList: input?.results),
        totalCount: input?.totalCount,
        totalPages: input?.totalPages);

    return out;
  }

  @override
  SampleQuotable? transform(SampleQuotableDTO? input) {
    SampleQuotable out = SampleQuotable(
        count: input?.count,
        page: input?.page,
        results: sampleQuotableResultsDTOMapper.transformList(inList: input?.results),
        totalCount: input?.totalCount,
        totalPages: input?.totalPages);

    return out;
  }
}

class SampleQuotableResultsDTOMapper extends Mapper<SampleQuotableDTOResults, SampleQuotableResults> {
  @override
  SampleQuotableDTOResults? reverse(SampleQuotableResults? input) {
    SampleQuotableDTOResults out = SampleQuotableDTOResults(
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
  SampleQuotableResults? transform(SampleQuotableDTOResults? input) {
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
