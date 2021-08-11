// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadListDTO _$LeadListDTOFromJson(Map<String, dynamic> json) {
  return LeadListDTO(
    leadNo: json['LeadNo'] as int?,
    customerName: json['CustomerName'] as String?,
    contactedVia: json['ContactedVia'] as String?,
    contactedDetails: json['ContactedDetails'] as String?,
    contactNo: json['ContactNo'] as String?,
    place: json['Place'] as String?,
    date: json['Date'] as String?,
  );
}

Map<String, dynamic> _$LeadListDTOToJson(LeadListDTO instance) =>
    <String, dynamic>{
      'LeadNo': instance.leadNo,
      'CustomerName': instance.customerName,
      'ContactedVia': instance.contactedVia,
      'ContactedDetails': instance.contactedDetails,
      'ContactNo': instance.contactNo,
      'Place': instance.place,
      'Date': instance.date,
    };
