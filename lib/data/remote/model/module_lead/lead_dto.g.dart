// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadDTO _$LeadDTOFromJson(Map<String, dynamic> json) {
  return LeadDTO(
    leadNo: json['LeadNo'] as int?,
    customerName: json['CustomerName'] as String?,
    contactedVia: json['ContactedVia'] as String?,
    contactedDetails: json['ContactedDetails'] as String?,
    contactNo: json['ContactNo'] as String?,
    place: json['Place'] as String?,
    date: json['Date'] as String?,
    productId: json['ProductId'] as int?,
    name: json['Name'] as String?,
    price: (json['Price'] as num?)?.toDouble(),
    quantity: json['Quantity'] as int?,
    description: json['Description'] as String?,
    images: (json['Images'] as List<dynamic>?)
        ?.map((e) => LeadImagesDTO.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$LeadDTOToJson(LeadDTO instance) => <String, dynamic>{
      'LeadNo': instance.leadNo,
      'CustomerName': instance.customerName,
      'ContactedVia': instance.contactedVia,
      'ContactedDetails': instance.contactedDetails,
      'ContactNo': instance.contactNo,
      'Place': instance.place,
      'Date': instance.date,
      'ProductId': instance.productId,
      'Name': instance.name,
      'Price': instance.price,
      'Quantity': instance.quantity,
      'Description': instance.description,
      'Images': instance.images,
    };

LeadImagesDTO _$LeadImagesDTOFromJson(Map<String, dynamic> json) {
  return LeadImagesDTO(
    id: json['Id'] as int?,
    image: json['Image'] as String?,
  );
}

Map<String, dynamic> _$LeadImagesDTOToJson(LeadImagesDTO instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Image': instance.image,
    };
