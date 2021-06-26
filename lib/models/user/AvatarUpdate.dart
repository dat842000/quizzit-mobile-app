import 'package:flutter_auth/models/Codable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'AvatarUpdate.g.dart';
@JsonSerializable()
class AvatarUpdate extends Encodable{
  String image;

  AvatarUpdate(this.image);

  @override
  Map<String, dynamic> toJson() => _$AvatarUpdateToJson(this);

}