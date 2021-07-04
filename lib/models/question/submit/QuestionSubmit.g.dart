// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuestionSubmit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionSubmit _$QuestionSubmitFromJson(Map<String, dynamic> json) {
  return QuestionSubmit(
    json['id'] as int,
    json['questionToken'] as int,
    json['answerId'] as int,
  );
}

Map<String, dynamic> _$QuestionSubmitToJson(QuestionSubmit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'questionToken': instance.questionToken,
      'answerId': instance.answerId,
    };
