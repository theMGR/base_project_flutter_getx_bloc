import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'lead_products_dto.g.dart';

@JsonSerializable()
class LeadProductsDTO {
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
  @JsonKey(name: "ProductImages")
  List<LeadProductImagesDTO>? productImages;

  LeadProductsDTO({this.productId, this.name, this.price, this.quantity, this.description, this.productImages});

  factory LeadProductsDTO.fromJson(Map<String, dynamic> json) => _$LeadProductsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LeadProductsDTOToJson(this);

  factory LeadProductsDTO.fromRawJson(String str) => LeadProductsDTO.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());
}

@JsonSerializable()
class LeadProductImagesDTO {
  @JsonKey(name: "Id")
  int? id;
  @JsonKey(name: "Image")
  String? image;

  LeadProductImagesDTO({this.id, this.image});

  factory LeadProductImagesDTO.fromJson(Map<String, dynamic> json) => _$LeadProductImagesDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LeadProductImagesDTOToJson(this);

  factory LeadProductImagesDTO.fromRawJson(String str) => LeadProductImagesDTO.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());
}
