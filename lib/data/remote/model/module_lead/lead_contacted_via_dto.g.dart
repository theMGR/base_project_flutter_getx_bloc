// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_contacted_via_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadContactedViaDTO _$LeadContactedViaDTOFromJson(Map<String, dynamic> json) {
  return LeadContactedViaDTO(
    id: json['Id'] as int?,
    name: json['Name'] as String?,
  );
}

Map<String, dynamic> _$LeadContactedViaDTOToJson(
        LeadContactedViaDTO instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
    };
