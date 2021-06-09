// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Page<T> _$PageFromJson<T extends Decodable>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return Page<T>()
    ..totalElements = json['totalElements'] as int
    ..totalPages = json['totalPages'] as int
    ..isFirst = json['isFirst'] as bool
    ..isLast = json['isLast'] as bool
    ..hasNext = json['hasNext'] as bool
    ..hasPrevious = json['hasPrevious'] as bool
    ..content = (json['content'] as List<dynamic>).map(fromJsonT).toList();
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
