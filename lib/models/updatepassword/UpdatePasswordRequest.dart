import 'package:json_annotation/json_annotation.dart';
import 'package:quizzit/models/Codable.dart';

part 'UpdatePasswordRequest.g.dart';

@JsonSerializable()
class UpdatePasswordRequest implements Encodable {
  String oldPassword = "";
  String newPassword = "";

  UpdatePasswordRequest(this.oldPassword, this.newPassword);

  @override
  Map<String, dynamic> toJson() => _$UpdatePasswordRequestToJson(this);
}
