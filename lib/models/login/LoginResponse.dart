import 'package:json_annotation/json_annotation.dart';
part 'LoginResponse.g.dart';
@JsonSerializable()
class LoginResponse{
  String customToken;

  LoginResponse(this.customToken);
  factory LoginResponse.fromJson(Map<String, dynamic> json)=>_$LoginResponseFromJson(json);
}