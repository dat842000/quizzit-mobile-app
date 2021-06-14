// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Page<T> _$PageFromJson<T extends Decodable>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return Page<T>(
    json['totalElements'] as int,
    json['totalPages'] as int,
    json['isFirst'] as bool,
    json['isLast'] as bool,
    json['hasNext'] as bool,
    json['hasPrevious'] as bool,
    (json['content'] as List<dynamic>).map(fromJsonT).toList(),
  );
}

Map<String, dynamic> _$PageToJson<T extends Decodable>(
  Page<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'isFirst': instance.isFirst,
      'isLast': instance.isLast,
      'hasNext': instance.hasNext,
      'hasPrevious': instance.hasPrevious,
      'content': instance.content.map(toJsonT).toList(),
    };
