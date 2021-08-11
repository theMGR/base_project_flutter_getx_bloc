// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_approve_cancel_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadApproveCancelDTO _$LeadApproveCancelDTOFromJson(Map<String, dynamic> json) {
  return LeadApproveCancelDTO(
    leadId: json['LeadId'] as int?,
    reason: json['Reason'] as String?,
    updatedBy: json['UpdatedBy'] as String?,
    updatedDate: json['UpdatedDate'] as String?,
  );
}

Map<String, dynamic> _$LeadApproveCancelDTOToJson(
    LeadApproveCancelDTO instance) {
  final val = <String, dynamic>{
    'LeadId': instance.leadId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Reason', instance.reason);
  val['UpdatedBy'] = instance.updatedBy;
  val['UpdatedDate'] = instance.updatedDate;
  return val;
}
