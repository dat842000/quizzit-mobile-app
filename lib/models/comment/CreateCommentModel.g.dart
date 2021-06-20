// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CreateCommentModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCommentModel _$CreateCommentModelFromJson(Map<String, dynamic> json) {
  return CreateCommentModel(
    json['content'] as String,
    image: json['image'] as String?,
  );
}

Map<String, dynamic> _$CreateCommentModelToJson(CreateCommentModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'image': instance.image,
    };
