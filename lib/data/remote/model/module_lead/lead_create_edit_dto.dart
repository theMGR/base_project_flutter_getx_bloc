import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'lead_create_edit_dto.g.dart';

@JsonSerializable()
class LeadCreateEditDTO {
  @JsonKey(name: "Id")
  int? id;
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
  @JsonKey(name: "CreatedBy", includeIfNull: false)
  String? createdBy;
  @JsonKey(name: "CreatedDate", includeIfNull: false)
  String? createdDate;
  @JsonKey(name: "UpdatedBy", includeIfNull: false)
  String? updatedBy;
  @JsonKey(name: "UpdatedDate", includeIfNull: false)
  String? updatedDate;
  @JsonKey(name: "ProductId")
  int? productId;
  @JsonKey(name: "ProductName")
  String? productName;
  @JsonKey(name: "Price")
  double? price;
  @JsonKey(name: "Quantity")
  int? quantity;
  @JsonKey(name: "Description")
  String? description;

  LeadCreateEditDTO(
      {this.id,
        this.customerName,
        this.contactedVia,
        this.contactedDetails,
        this.contactNo,
        this.place,
        this.createdBy,
        this.createdDate,
        this.updatedBy, this.updatedDate,
        this.productId,
        this.productName,
        this.price,
        this.quantity,
        this.description});

  factory LeadCreateEditDTO.fromJson(Map<String, dynamic> json) => _$LeadCreateEditDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LeadCreateEditDTOToJson(this);

  factory LeadCreateEditDTO.fromRawJson(String str) =>
      LeadCreateEditDTO.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());
}
