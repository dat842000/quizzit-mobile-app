import 'package:flutter_auth/models/Codable.dart';
import 'package:flutter_auth/models/user/BaseUser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Member.g.dart';

@JsonSerializable()
class Member extends BaseUser implements Codable {
  int status;

  Member(int id, String username, String fullName, String? avatar, String email, DateTime dateOfBirth, this.status) : super(id, username, fullName, avatar, email, dateOfBirth);

  factory Member.fromJson(Map<String, dynamic> json) =>
      _$MemberFromJson(json);
  static Member fromJsonModel(Map<String, dynamic> json) => Member.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return _$MemberToJson(this);
  }
}