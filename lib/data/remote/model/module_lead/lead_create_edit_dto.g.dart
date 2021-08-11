// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_create_edit_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadCreateEditDTO _$LeadCreateEditDTOFromJson(Map<String, dynamic> json) {
  return LeadCreateEditDTO(
    id: json['Id'] as int?,
    customerName: json['CustomerName'] as String?,
    contactedVia: json['ContactedVia'] as String?,
    contactedDetails: json['ContactedDetails'] as String?,
    contactNo: json['ContactNo'] as String?,
    place: json['Place'] as String?,
    createdBy: json['CreatedBy'] as String?,
    createdDate: json['CreatedDate'] as String?,
    updatedBy: json['UpdatedBy'] as String?,
    updatedDate: json['UpdatedDate'] as String?,
    productId: json['ProductId'] as int?,
    productName: json['ProductName'] as String?,
    price: (json['Price'] as num?)?.toDouble(),
    quantity: json['Quantity'] as int?,
    description: json['Description'] as String?,
  );
}

Map<String, dynamic> _$LeadCreateEditDTOToJson(LeadCreateEditDTO instance) {
  final val = <String, dynamic>{
    'Id': instance.id,
    'CustomerName': instance.customerName,
    'ContactedVia': instance.contactedVia,
    'ContactedDetails': instance.contactedDetails,
    'ContactNo': instance.contactNo,
    'Place': instance.place,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('CreatedBy', instance.createdBy);
  writeNotNull('CreatedDate', instance.createdDate);
  writeNotNull('UpdatedBy', instance.updatedBy);
  writeNotNull('UpdatedDate', instance.updatedDate);
  val['ProductId'] = instance.productId;
  val['ProductName'] = instance.productName;
  val['Price'] = instance.price;
  val['Quantity'] = instance.quantity;
  val['Description'] = instance.description;
  return val;
}
