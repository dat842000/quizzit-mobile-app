import 'package:json_annotation/json_annotation.dart';
import 'package:quizzit/models/Codable.dart';

import 'BaseUser.dart';

part 'UserInfo.g.dart';

@JsonSerializable()
class UserInfo extends BaseUser implements Decodable {
  int totalOwnedGroup;
  int totalJoinedGroup;

  UserInfo(
      int id,
      String username,
      String fullName,
      String? avatar,
      String email,
      DateTime dateOfBirth,
      this.totalOwnedGroup,
      this.totalJoinedGroup)
      : super(id, username, fullName, avatar, email, dateOfBirth);
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}
