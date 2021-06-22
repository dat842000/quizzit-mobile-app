// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    json['id'] as int,
    json['content'] as String,
    json['image'] as String?,
    DateTime.parse(json['createdAt'] as String),
    BaseUser.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'image': instance.image,
      'createdAt': instance.createdAt.toIso8601String(),
      'user': instance.user,
    };
