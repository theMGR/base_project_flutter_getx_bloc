import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'lead_list_dto.g.dart';


@JsonSerializable()
class LeadListDTO {
  @JsonKey(name: "LeadNo")
  int? leadNo;
  @JsonKey(name: "CustomerName")
  String? customerName;
  @JsonKey(name: "ContactedVia")
  String? contactedVia;
  @JsonKey(name: "ContactedDetails")
  String? contactedDetails;
  @JsonKey(name: "ContactNo")
  String? contactNo;
  @JsonKey(name: "Place")
  String? place;
  @JsonKey(name: "Date")
  String? date;

  LeadListDTO({this.leadNo,
    this.customerName,
    this.contactedVia,
    this.contactedDetails,
    this.contactNo,
    this.place,
    this.date});

  factory LeadListDTO.fromJson(Map<String, dynamic> json) => _$LeadListDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LeadListDTOToJson(this);

  factory LeadListDTO.fromRawJson(String str) =>
      LeadListDTO.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());


}
