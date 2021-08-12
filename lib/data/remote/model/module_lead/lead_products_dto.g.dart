// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_products_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadProductsDTO _$LeadProductsDTOFromJson(Map<String, dynamic> json) {
  return LeadProductsDTO(
    productId: json['ProductId'] as int?,
    name: json['Name'] as String?,
    price: (json['Price'] as num?)?.toDouble(),
    quantity: json['Quantity'] as int?,
    description: json['Description'] as String?,
    productImages: (json['ProductImages'] as List<dynamic>?)
        ?.map((e) => LeadProductImagesDTO.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$LeadProductsDTOToJson(LeadProductsDTO instance) =>
    <String, dynamic>{
      'ProductId': instance.productId,
      'Name': instance.name,
      'Price': instance.price,
      'Quantity': instance.quantity,
      'Description': instance.description,
      'ProductImages': instance.productImages,
    };

LeadProductImagesDTO _$LeadProductImagesDTOFromJson(Map<String, dynamic> json) {
  return LeadProductImagesDTO(
    id: json['Id'] as int?,
    image: json['Image'] as String?,
  );
}

Map<String, dynamic> _$LeadProductImagesDTOToJson(
        LeadProductImagesDTO instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Image': instance.image,
    };
