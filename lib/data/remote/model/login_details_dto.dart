import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'login_details_dto.g.dart';

@JsonSerializable()
class LoginDetailsDTO {
  @JsonKey(name: "UserId")
  int? userId;
  @JsonKey(name: "UserName")
  String? userName;
  @JsonKey(name: "Password")
  String? password;
  @JsonKey(name: "MobileNo")
  String? mobileNo;
  @JsonKey(name: "Department")
  List<LoginDetailsDepartmentDTO>? department;

  LoginDetailsDTO(
      {this.userId,
        this.userName,
        this.password,
        this.mobileNo,
        this.department});

  factory LoginDetailsDTO.fromJson(Map<String, dynamic> json) => _$LoginDetailsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDetailsDTOToJson(this);

  factory LoginDetailsDTO.fromRawJson(String str) =>
      LoginDetailsDTO.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());


}

@JsonSerializable()
class LoginDetailsDepartmentDTO {
  @JsonKey(name: "Name")
  String? name;

  LoginDetailsDepartmentDTO({this.name});

  factory LoginDetailsDepartmentDTO.fromJson(Map<String, dynamic> json) => _$LoginDetailsDepartmentDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDetailsDepartmentDTOToJson(this);

  factory LoginDetailsDepartmentDTO.fromRawJson(String str) =>
      LoginDetailsDepartmentDTO.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());


}