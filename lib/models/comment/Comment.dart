import 'package:flutter_auth/models/Codable.dart';
import 'package:flutter_auth/models/user/BaseUser.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Comment.g.dart';
@JsonSerializable()
class Comment implements Decodable{
  int id;
  String content;
  String? image;
  DateTime createdAt;
  BaseUser user;

  Comment(this.id, this.content, this.image, this.createdAt, this.user);
  factory Comment.fromJson(Map<String,dynamic>json)=>_$CommentFromJson(json);
  static Comment fromJsonModel(Map<String,dynamic>json)=>Comment.fromJson(json);
}