// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_local_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationLocalDTO _$NotificationLocalDTOFromJson(Map<String, dynamic> json) {
  return NotificationLocalDTO(
    notificationId: json['notificationId'] as int?,
    title: json['title'] as String?,
    body: json['body'] as String?,
    value1: json['value1'] as String?,
    value2: json['value2'] as String?,
  );
}

Map<String, dynamic> _$NotificationLocalDTOToJson(
        NotificationLocalDTO instance) =>
    <String, dynamic>{
      'notificationId': instance.notificationId,
      'title': instance.title,
      'body': instance.body,
      'value1': instance.value1,
      'value2': instance.value2,
    };
