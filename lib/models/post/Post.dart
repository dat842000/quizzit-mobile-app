import 'package:flutter_auth/models/Codable.dart';
import 'package:flutter_auth/models/user/BaseUser.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:json_annotation/json_annotation.dart';

import 'CreatePostModel.dart';

part 'Post.g.dart';

@JsonSerializable()
class Post extends CreatePostModel implements Decodable {
  int id;
  bool isActive;
  @JsonKey(fromJson: fromJsonUTC)
  DateTime createdAt;
  BaseUser user;

  Post(this.id, title, content, image, this.isActive, this.createdAt, this.user)
      : super(title, content, image: image);
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  static fromJsonModel(Map<String, dynamic> json) => Post.fromJson(json);
}
