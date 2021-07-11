import 'package:json_annotation/json_annotation.dart';
import 'package:quizzit/models/Codable.dart';

part 'CreateCommentModel.g.dart';

@JsonSerializable(includeIfNull: false)
class CreateCommentModel implements Encodable {
  String content;
  String? image;

  CreateCommentModel(this.content, {this.image});

  @override
  Map<String, dynamic> toJson() => _$CreateCommentModelToJson(this);
}
