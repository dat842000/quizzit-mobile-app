// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CreatePostModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePostModel _$CreatePostModelFromJson(Map<String, dynamic> json) {
  return CreatePostModel(
    json['title'] as String,
    json['content'] as String,
    image: json['image'] as String?,
  );
}

Map<String, dynamic> _$CreatePostModelToJson(CreatePostModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'image': instance.image,
    };
