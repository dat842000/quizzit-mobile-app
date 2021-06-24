// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Answers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) {
  return Answer(
    json['id'] as int,
    json['content'] as String,
    json['isCorrect'] as bool,
  );
}

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'isCorrect': instance.isCorrect,
    };
