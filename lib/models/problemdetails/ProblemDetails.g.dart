// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProblemDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProblemDetails _$ProblemDetailsFromJson(Map<String, dynamic> json) {
  return ProblemDetails(
    json['type'] as String?,
    json['title'] as String?,
    json['message'] as String?,
    (json['params'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, e as String),
    ),
    json['errors'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$ProblemDetailsToJson(ProblemDetails instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'message': instance.message,
      'params': instance.params,
      'errors': instance.errors,
    };
