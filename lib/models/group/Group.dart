import 'package:flutter_auth/models/Codable.dart';
import 'package:flutter_auth/models/user/UserInfo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_auth/models/subject/Subject.dart';
part 'Group.g.dart';
@JsonSerializable()
class Group implements Decodable{
  int id;
  String name;
  String? image;
  int quizSize;
  bool isActive;
  DateTime createAt;
  int totalMem;
  List<Subject> subjects;
  UserInfo owner;
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

  factory Group.fromJson(Map<String,dynamic>json)=>_$GroupFromJson(json);
  static Group fromJsonModel(Map<String, dynamic> json) => Group.fromJson(json);
}