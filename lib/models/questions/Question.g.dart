// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    json['id'] as int,
    json['content'] as String,
    json['inSubject'] as int,
    DateTime.parse(json['updateAt'] as String),
    json['createdBy'] as String,
    json['isPrivate'] as bool,
    json['isAdd'] as bool,
    (json['answers'] as List<dynamic>)
        .map((e) => Answer.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'inSubject': instance.inSubject,
      'updateAt': instance.updateAt.toIso8601String(),
      'createdBy': instance.createdBy,
      'isPrivate': instance.isPrivate,
      'isAdd': instance.isAdd,
      'answers': instance.answers,
    };
