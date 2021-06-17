// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserInfoUpdateModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoUpdateModel _$UserInfoUpdateModelFromJson(Map<String, dynamic> json) {
  return UserInfoUpdateModel(
    json['email'] as String,
    json['fullName'] as String,
    DateTime.parse(json['dateOfBirth'] as String),
  );
}

Map<String, dynamic> _$UserInfoUpdateModelToJson(
        UserInfoUpdateModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'fullName': instance.fullName,
      'dateOfBirth': UserInfoUpdateModel.convertDate(instance.dateOfBirth),
    };
