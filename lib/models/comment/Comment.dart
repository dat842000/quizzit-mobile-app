import 'package:json_annotation/json_annotation.dart';
import 'package:quizzit/models/Codable.dart';
import 'package:quizzit/models/user/BaseUser.dart';
import 'package:quizzit/utils/ApiUtils.dart';

part 'Comment.g.dart';

@JsonSerializable()
class Comment implements Decodable {
  int id;
  String content;
  String? image;
  @JsonKey(fromJson: fromJsonUTC)
  DateTime createdAt;
  BaseUser user;

  Comment(this.id, this.content, this.image, this.createdAt, this.user);
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  static Comment fromJsonModel(Map<String, dynamic> json) =>
      Comment.fromJson(json);
}
