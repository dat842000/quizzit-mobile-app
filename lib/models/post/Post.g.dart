// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    json['id'] as int,
    json['title'],
    json['content'],
    json['image'],
    json['isActive'] as bool,
    fromJsonUTC(json['createdAt'] as String),
    BaseUser.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'image': instance.image,
      'id': instance.id,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'user': instance.user,
    };
