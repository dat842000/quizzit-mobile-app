// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
    json['id'] as int,
    json['username'] as String,
    json['fullName'] as String,
    json['avatar'] as String,
    json['email'] as String,
    DateTime.parse(json['dateOfBirth'] as String),
    json['totalOwnedGroup'] as int,
    json['totalJoinedGroup'] as int,
  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'fullName': instance.fullName,
      'avatar': instance.avatar,
      'email': instance.email,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'totalOwnedGroup': instance.totalOwnedGroup,
      'totalJoinedGroup': instance.totalJoinedGroup,
    };
