import 'package:flutter_auth/models/Codable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'BaseUser.g.dart';

@JsonSerializable()
class BaseUser implements Decodable {
  int id;
  String username;
  String fullName;
  String? avatar;
  String email;
  DateTime dateOfBirth;

  BaseUser(this.id, this.username, this.fullName, this.avatar, this.email, this.dateOfBirth);

  factory BaseUser.fromJson(Map<String, dynamic> json) =>
      _$BaseUserFromJson(json);
}
