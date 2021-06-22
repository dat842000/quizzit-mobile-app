// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BaseUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseUser _$BaseUserFromJson(Map<String, dynamic> json) {
  return BaseUser(
    json['id'] as int,
    json['username'] as String,
    json['fullName'] as String,
    json['avatar'] as String?,
    json['email'] as String,
    DateTime.parse(json['dateOfBirth'] as String),
  );
}

Map<String, dynamic> _$BaseUserToJson(BaseUser instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'fullName': instance.fullName,
      'avatar': instance.avatar,
      'email': instance.email,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
    };
