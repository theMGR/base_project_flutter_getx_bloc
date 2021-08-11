import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'lead_dto.g.dart';

@JsonSerializable()
class LeadDTO {
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
  @JsonKey(name: "ProductId")
  int? productId;
  @JsonKey(name: "Name")
  String? name;
  @JsonKey(name: "Price")
  double? price;
  @JsonKey(name: "Quantity")
  int? quantity;
  @JsonKey(name: "Description")
  String? description;
  @JsonKey(name: "Images")
  List<LeadImagesDTO>? images;

  LeadDTO(
      {this.leadNo,
        this.customerName,
        this.contactedVia,
        this.contactedDetails,
        this.contactNo,
        this.place,
        this.date,
        this.productId,
        this.name,
        this.price,
        this.quantity,
        this.description,
        this.images});

  factory LeadDTO.fromJson(Map<String, dynamic> json) => _$LeadDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LeadDTOToJson(this);

  factory LeadDTO.fromRawJson(String str) =>
      LeadDTO.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

}

@JsonSerializable()
class LeadImagesDTO {
  @JsonKey(name: "Id")
  int? id;
  @JsonKey(name: "Image")
  String? image;

  LeadImagesDTO({this.id, this.image});

  factory LeadImagesDTO.fromJson(Map<String, dynamic> json) => _$LeadImagesDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LeadImagesDTOToJson(this);

  factory LeadImagesDTO.fromRawJson(String str) =>
      LeadImagesDTO.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());
}
