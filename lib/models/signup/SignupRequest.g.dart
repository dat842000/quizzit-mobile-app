// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SignupRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupRequest _$SignupRequestFromJson(Map<String, dynamic> json) {
  return SignupRequest(
    json['username'] as String,
    json['password'] as String,
    json['fullName'] as String,
    json['email'] as String,
    DateTime.parse(json['dateOfBirth'] as String),
  );
}

Map<String, dynamic> _$SignupRequestToJson(SignupRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'fullName': instance.fullName,
      'email': instance.email,
      'dateOfBirth': SignupRequest.formatDate(instance.dateOfBirth),
    };
