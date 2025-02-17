import 'package:flutter_auth/models/Codable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Answer.g.dart';
@JsonSerializable()
class Answer implements Decodable{
  String content;
  int id;


  Answer(this.content, this.id);

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);
  static Answer fromJsonModel(Map<String, dynamic> json) => Answer.fromJson(json);
}