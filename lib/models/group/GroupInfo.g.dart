// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GroupInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupInfo _$GroupInfoFromJson(Map<String, dynamic> json) {
  return GroupInfo(
    json['id'] as int,
    json['name'] as String,
    json['image'] as String?,
    json['quizSize'] as int,
    json['isActive'] as bool,
    DateTime.parse(json['createAt'] as String),
    json['totalMem'] as int,
    (json['subjects'] as List<dynamic>)
        .map((e) => Subject.fromJson(e as Map<String, dynamic>))
        .toList(),
    BaseUser.fromJson(json['owner'] as Map<String, dynamic>),
    json['currentMemberStatus'] as int,
    json['totalPost'] as int,
    json['totalQuestions'] as int,
    json['totalQuizzesIn30Days'] as int,
    json['totalSubjects'] as int,
  );
}

Map<String, dynamic> _$GroupInfoToJson(GroupInfo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'quizSize': instance.quizSize,
      'isActive': instance.isActive,
      'createAt': instance.createAt.toIso8601String(),
      'totalMem': instance.totalMem,
      'subjects': instance.subjects,
      'owner': instance.owner,
      'currentMemberStatus': instance.currentMemberStatus,
      'totalPost': instance.totalPost,
      'totalSubjects': instance.totalSubjects,
      'totalQuestions': instance.totalQuestions,
      'totalQuizzesIn30Days': instance.totalQuizzesIn30Days,
    };
