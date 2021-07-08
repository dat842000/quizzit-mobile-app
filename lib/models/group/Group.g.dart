// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) {
  return Group(
    json['id'] as int,
    json['name'] as String,
    json['image'] as String?,
    json['quizSize'] as int,
    json['isActive'] as bool,
    fromJsonUTC(json['createAt'] as String),
    json['totalMem'] as int,
    (json['subjects'] as List<dynamic>)
        .map((e) => Subject.fromJson(e as Map<String, dynamic>))
        .toList(),
    BaseUser.fromJson(json['owner'] as Map<String, dynamic>),
    json['currentMemberStatus'] as int,
  );
}

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
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
    };
