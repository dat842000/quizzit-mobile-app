import 'package:json_annotation/json_annotation.dart';

import '../Codable.dart';

part 'CreatePostModel.g.dart';
@JsonSerializable()
class CreatePostModel implements Encodable{
  String title;
  String content;
  String? image;

  CreatePostModel(this.title, this.content, this.image);

  @override
  Map<String, dynamic> toJson() => _$CreatePostModelToJson(this);
}