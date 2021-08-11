import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'lead_approve_cancel_dto.g.dart';

@JsonSerializable()
class LeadApproveCancelDTO {
  @JsonKey(name: "LeadId")
  int? leadId;
  @JsonKey(name: "Reason", includeIfNull: false)
  String? reason;
  @JsonKey(name: "UpdatedBy")
  String? updatedBy;
  @JsonKey(name: "UpdatedDate")
  String? updatedDate;

  LeadApproveCancelDTO(
      {this.leadId, this.reason, this.updatedBy, this.updatedDate});

  factory LeadApproveCancelDTO.fromJson(Map<String, dynamic> json) => _$LeadApproveCancelDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LeadApproveCancelDTOToJson(this);

  factory LeadApproveCancelDTO.fromRawJson(String str) =>
      LeadApproveCancelDTO.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());
}
