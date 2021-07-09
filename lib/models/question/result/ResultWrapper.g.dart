// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResultWrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultWrapper<T> _$ResultWrapperFromJson<T extends Decodable>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return ResultWrapper<T>(
    json['id'] as int,
    json['numberOfQuestion'] as int,
    json['numberOfCorrectAnswer'] as int,
    json['answerAt'] as String,
    BaseUser.fromJson(json['answerBy'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResultWrapperToJson<T extends Decodable>(
  ResultWrapper<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'id': instance.id,
      'numberOfQuestion': instance.numberOfQuestion,
      'numberOfCorrectAnswer': instance.numberOfCorrectAnswer,
      'answerAt': instance.answerAt,
      'answerBy': instance.answerBy,
    };
