// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'QuestionsWrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionsWrapper<T> _$QuestionsWrapperFromJson<T extends Decodable>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return QuestionsWrapper<T>(
    json['numberOfQuestion'] as int,
    (json['questions'] as List<dynamic>)
        .map((e) => Question.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['id'] as int,
  );
}

Map<String, dynamic> _$QuestionsWrapperToJson<T extends Decodable>(
  QuestionsWrapper<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'numberOfQuestion': instance.numberOfQuestion,
      'questions': instance.questions,
      'id': instance.id,
    };
