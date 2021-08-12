import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:project/core/utils/print_utils.dart';

part 'sample_dto.g.dart';

@JsonSerializable()
class SampleQuotableDTO {
  final int? count;
  final int? totalCount;
  final int? page;
  final int? totalPages;
  final List<SampleQuotableDTOResults>? results;


  SampleQuotableDTO({this.count, this.totalCount, this.page, this.totalPages, this.results});

  factory SampleQuotableDTO.fromJson(Map<String, dynamic> json) => _$SampleQuotableDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SampleQuotableDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  static SampleQuotableDTO? getFromJson(String? json) {
    if(json != null) {
      try {
        return SampleQuotableDTO.fromJson(jsonDecode(json));
      } catch (e) {
        Print.Debug("SampleQuotableDTO: getFromJson() Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }
}


@JsonSerializable()
class SampleQuotableDTOResults {
  @JsonKey(name: '_id')
  final String? id;
  final String? author;
  final String? content;
  final String? authorSlug;
  final int? length;
  final String? dateAdded;
  final String? dateModified;


  SampleQuotableDTOResults({this.id, this.author, this.content, this.authorSlug, this.length, this.dateAdded, this.dateModified});

  factory SampleQuotableDTOResults.fromJson(Map<String, dynamic> json) => _$SampleQuotableDTOResultsFromJson(json);

  Map<String, dynamic> toJson() => _$SampleQuotableDTOResultsToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  static SampleQuotableDTOResults? getFromJson(String? json) {
    if(json != null) {
      try {
        return SampleQuotableDTOResults.fromJson(jsonDecode(json));
      } catch (e) {
        Print.Debug("SampleQuotableDTOResults: getFromJson() Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }
}

@JsonSerializable()
class HttpBinResponse {
  final String data;


  HttpBinResponse({required this.data});



  factory HttpBinResponse.fromJson(Map<String, dynamic> json) => _$HttpBinResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HttpBinResponseToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  static HttpBinResponse? getFromJson(String? json) {
    if(json != null) {
      try {
        return HttpBinResponse.fromJson(jsonDecode(json));
      } catch (e) {
        Print.Debug("HttpBinResponse: getFromJson() Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }
}
