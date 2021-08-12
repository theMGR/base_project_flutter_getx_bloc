import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:project/core/utils/print_utils.dart';

part 'notification_local_dto.g.dart';

@JsonSerializable()
class NotificationLocalDTO{
  int? notificationId;
  String? title;
  String? body;
  String? value1;
  String? value2;

  NotificationLocalDTO({this.notificationId, this.title, this.body, this.value1, this.value2});

  factory NotificationLocalDTO.fromJson(Map<String, dynamic> json) => _$NotificationLocalDTOFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationLocalDTOToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  static NotificationLocalDTO? getFromJson(String? json) {
    if(json != null) {
      try {
        return NotificationLocalDTO.fromJson(jsonDecode(json));
      } catch (e) {
        Print.Debug("NotificationLocalDTO: getFromJson() Exception :: $e");
        return null;
      }
    } else {
      return null;
    }
  }
}

