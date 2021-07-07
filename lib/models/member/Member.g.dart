// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) {
  return Member(
    json['id'] as int,
    json['username'] as String,
    json['fullName'] as String,
    json['avatar'] as String?,
    json['email'] as String,
    DateTime.parse(json['dateOfBirth'] as String),
    json['status'] as int,
  );
}

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'fullName': instance.fullName,
      'avatar': instance.avatar,
      'email': instance.email,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'status': instance.status,
    };
