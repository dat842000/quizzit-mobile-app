import 'package:json_annotation/json_annotation.dart';

import '../Codable.dart';

part 'EditPostModel.g.dart';
@JsonSerializable()
class EditPostModel implements Encodable{
  String title;
  String content;
  String? image;

  EditPostModel(this.title, this.content, this.image);

  @override
  Map<String, dynamic> toJson() => _$EditPostModelToJson(this);
}