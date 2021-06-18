import 'package:flutter_auth/models/Codable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'UserInfo.g.dart';
@JsonSerializable()
class UserInfo implements Decodable{
  int id;
  String username;
  String fullName;
  String? avatar;
  String email;
  DateTime dateOfBirth;
  int totalOwnedGroup;
  int totalJoinedGroup;

  UserInfo(this.id, this.username, this.fullName, this.avatar, this.email,
      this.dateOfBirth, this.totalOwnedGroup, this.totalJoinedGroup);

  factory UserInfo.fromJson(Map<String,dynamic>json)=>_$UserInfoFromJson(json);
}