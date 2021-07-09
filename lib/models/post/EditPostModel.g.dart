// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EditPostModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditPostModel _$EditPostModelFromJson(Map<String, dynamic> json) {
  return EditPostModel(
    json['title'] as String,
    json['content'] as String,
    json['image'] as String?,
  );
}

Map<String, dynamic> _$EditPostModelToJson(EditPostModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'image': instance.image,
    };
