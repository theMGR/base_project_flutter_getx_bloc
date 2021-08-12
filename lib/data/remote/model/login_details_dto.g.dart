// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDetailsDTO _$LoginDetailsDTOFromJson(Map<String, dynamic> json) {
  return LoginDetailsDTO(
    userId: json['UserId'] as int?,
    userName: json['UserName'] as String?,
    password: json['Password'] as String?,
    mobileNo: json['MobileNo'] as String?,
    department: (json['Department'] as List<dynamic>?)
        ?.map((e) =>
            LoginDetailsDepartmentDTO.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$LoginDetailsDTOToJson(LoginDetailsDTO instance) =>
    <String, dynamic>{
      'UserId': instance.userId,
      'UserName': instance.userName,
      'Password': instance.password,
      'MobileNo': instance.mobileNo,
      'Department': instance.department,
    };

LoginDetailsDepartmentDTO _$LoginDetailsDepartmentDTOFromJson(
    Map<String, dynamic> json) {
  return LoginDetailsDepartmentDTO(
    name: json['Name'] as String?,
  );
}

Map<String, dynamic> _$LoginDetailsDepartmentDTOToJson(
        LoginDetailsDepartmentDTO instance) =>
    <String, dynamic>{
      'Name': instance.name,
    };
