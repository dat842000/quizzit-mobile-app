// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Rank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rank _$RankFromJson(Map<String, dynamic> json) {
  return Rank(
    json['id'] as int,
    json['username'] as String,
    json['fullName'] as String,
    json['avatar'] as String?,
    json['email'] as String,
    DateTime.parse(json['dateOfBirth'] as String),
    json['status'] as int,
    json['totalQuizzesIn30Days'] as int,
    json['totalCorrectAnswersIn30Days'] as int,
  );
}

Map<String, dynamic> _$RankToJson(Rank instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'fullName': instance.fullName,
      'avatar': instance.avatar,
      'email': instance.email,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'status': instance.status,
      'totalQuizzesIn30Days': instance.totalQuizzesIn30Days,
      'totalCorrectAnswersIn30Days': instance.totalCorrectAnswersIn30Days,
    };
