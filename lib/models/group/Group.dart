import 'package:flutter_auth/models/Codable.dart';
import 'package:flutter_auth/models/subject/Subject.dart';
import 'package:flutter_auth/models/user/BaseUser.dart';
import 'package:flutter_auth/utils/ApiUtils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Group.g.dart';

@JsonSerializable()
class Group implements Decodable {
  int id;
  String name;
  String? image;
  int quizSize;
  bool isActive;
  @JsonKey(fromJson: fromJsonUTC)
  DateTime createAt;
  int totalMem;
  List<Subject> subjects;
  BaseUser owner;
  int currentMemberStatus;

  Group(
      this.id,
      this.name,
      this.image,
      this.quizSize,
      this.isActive,
      this.createAt,
      this.totalMem,
      this.subjects,
      this.owner,
      this.currentMemberStatus);

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
  static Group fromJsonModel(Map<String, dynamic> json) => Group.fromJson(json);
}
