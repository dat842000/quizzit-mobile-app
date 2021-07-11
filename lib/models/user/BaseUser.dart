import 'package:json_annotation/json_annotation.dart';
import 'package:quizzit/models/Codable.dart';

part 'BaseUser.g.dart';

@JsonSerializable()
class BaseUser implements Codable {
  int id;
  String username;
  String fullName;
  String? avatar;
  String email;
  DateTime dateOfBirth;

  BaseUser(this.id, this.username, this.fullName, this.avatar, this.email,
      this.dateOfBirth);

  factory BaseUser.fromJson(Map<String, dynamic> json) =>
      _$BaseUserFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return _$BaseUserToJson(this);
  }
}
