// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CreateGroupModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateGroupModel _$CreateGroupModelFromJson(Map<String, dynamic> json) {
  return CreateGroupModel(
    json['groupName'] as String,
    json['quizSize'] as int,
    json['image'] as String?,
    (json['subjectIds'] as List<dynamic>).map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$CreateGroupModelToJson(CreateGroupModel instance) =>
    <String, dynamic>{
      'groupName': instance.groupName,
      'quizSize': instance.quizSize,
      'image': instance.image,
      'subjectIds': instance.subjectIds,
    };
