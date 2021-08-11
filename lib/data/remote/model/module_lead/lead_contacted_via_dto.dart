import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'lead_contacted_via_dto.g.dart';

@JsonSerializable()
class LeadContactedViaDTO {
  @JsonKey(name: "Id")
  int? id;
  @JsonKey(name: "Name")
  String? name;

  LeadContactedViaDTO({this.id, this.name});

  factory LeadContactedViaDTO.fromJson(Map<String, dynamic> json) => _$LeadContactedViaDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LeadContactedViaDTOToJson(this);

  factory LeadContactedViaDTO.fromRawJson(String str) =>
      LeadContactedViaDTO.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());
}
