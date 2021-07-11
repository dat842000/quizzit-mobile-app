import 'package:json_annotation/json_annotation.dart';
import 'package:quizzit/models/Codable.dart';

part 'LoginResponse.g.dart';

@JsonSerializable()
class LoginResponse implements Decodable {
  String customToken;

  LoginResponse(this.customToken);
  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
