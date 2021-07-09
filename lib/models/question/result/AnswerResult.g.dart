// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AnswerResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerResult _$AnswerResultFromJson(Map<String, dynamic> json) {
  return AnswerResult(
    json['question'] as String,
    json['answer'] as String,
    json['isCorrect'] as bool,
  );
}

Map<String, dynamic> _$AnswerResultToJson(AnswerResult instance) =>
    <String, dynamic>{
      'question': instance.question,
      'answer': instance.answer,
      'isCorrect': instance.isCorrect,
    };
