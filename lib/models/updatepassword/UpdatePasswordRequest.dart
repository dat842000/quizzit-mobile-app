import 'package:flutter_auth/models/Codable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'UpdatePasswordRequest.g.dart';
@JsonSerializable()
class UpdatePasswordRequest implements Encodable{
  String oldPassword="";
  String newPassword="";

  @override
  Map<String, dynamic> toJson() => _$UpdatePasswordRequestToJson(this);
}