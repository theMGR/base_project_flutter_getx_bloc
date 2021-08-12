// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SampleQuotableDTO _$SampleQuotableDTOFromJson(Map<String, dynamic> json) {
  return SampleQuotableDTO(
    count: json['count'] as int?,
    totalCount: json['totalCount'] as int?,
    page: json['page'] as int?,
    totalPages: json['totalPages'] as int?,
    results: (json['results'] as List<dynamic>?)
        ?.map(
            (e) => SampleQuotableDTOResults.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SampleQuotableDTOToJson(SampleQuotableDTO instance) =>
    <String, dynamic>{
      'count': instance.count,
      'totalCount': instance.totalCount,
      'page': instance.page,
      'totalPages': instance.totalPages,
      'results': instance.results,
    };

SampleQuotableDTOResults _$SampleQuotableDTOResultsFromJson(
    Map<String, dynamic> json) {
  return SampleQuotableDTOResults(
    id: json['_id'] as String?,
    author: json['author'] as String?,
    content: json['content'] as String?,
    authorSlug: json['authorSlug'] as String?,
    length: json['length'] as int?,
    dateAdded: json['dateAdded'] as String?,
    dateModified: json['dateModified'] as String?,
  );
}

Map<String, dynamic> _$SampleQuotableDTOResultsToJson(
        SampleQuotableDTOResults instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'author': instance.author,
      'content': instance.content,
      'authorSlug': instance.authorSlug,
      'length': instance.length,
      'dateAdded': instance.dateAdded,
      'dateModified': instance.dateModified,
    };

HttpBinResponse _$HttpBinResponseFromJson(Map<String, dynamic> json) {
  return HttpBinResponse(
    data: json['data'] as String,
  );
}

Map<String, dynamic> _$HttpBinResponseToJson(HttpBinResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
