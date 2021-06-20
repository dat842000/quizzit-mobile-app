import 'package:flutter_auth/models/Codable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'CreateCommentModel.g.dart';
@JsonSerializable()
class CreateCommentModel implements Encodable{
  String content;
  String? image;

  CreateCommentModel(this.content, {this.image});

  @override
  Map<String, dynamic> toJson() => _$CreateCommentModelToJson(this);

}