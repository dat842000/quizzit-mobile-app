// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuestionCreate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionCreate _$QuestionCreateFromJson(Map<String, dynamic> json) {
  return QuestionCreate(
    json['content'] as String,
    json['inSubject'] as int,
    json['isPrivate'] as bool?,
    (json['answers'] as List<dynamic>)
        .map((e) => Answer.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$QuestionCreateToJson(QuestionCreate instance) =>
    <String, dynamic>{
      'content': instance.content,
      'inSubject': instance.inSubject,
      'isPrivate': instance.isPrivate,
      'answers': instance.answers,
    };
