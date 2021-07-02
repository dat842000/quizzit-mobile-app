// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UpdateGroupModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateGroupModel _$UpdateGroupModelFromJson(Map<String, dynamic> json) {
  return UpdateGroupModel(
    json['groupName'] as String,
    json['quizSize'] as int,
    json['image'] as String?,
    (json['subjectIds'] as List<dynamic>).map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$UpdateGroupModelToJson(UpdateGroupModel instance) =>
    <String, dynamic>{
      'groupName': instance.groupName,
      'quizSize': instance.quizSize,
      'image': instance.image,
      'subjectIds': instance.subjectIds,
    };
