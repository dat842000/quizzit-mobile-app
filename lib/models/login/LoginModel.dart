import 'package:json_annotation/json_annotation.dart';
part 'LoginModel.g.dart';
@JsonSerializable()
class LoginRequest {
  String username="";
  String password="";

  LoginRequest(this.username, this.password);

}