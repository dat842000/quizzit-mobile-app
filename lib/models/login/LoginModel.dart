import 'package:json_annotation/json_annotation.dart';
import 'package:quizzit/models/Codable.dart';

part 'LoginModel.g.dart';

@JsonSerializable()
class LoginRequest implements Encodable {
  String username;
  String password;

  LoginRequest(this.username, this.password);

  @override
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
