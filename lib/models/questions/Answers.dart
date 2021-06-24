import 'package:flutter_auth/models/Codable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Answers.g.dart';
@JsonSerializable()
class Answer implements Decodable{
  int id;
  String content;
  bool isCorrect;

  Answer(
      this.id,
      this.content,
      this.isCorrect);

  factory Answer.fromJson(Map<String,dynamic>json)=>_$AnswerFromJson(json);
  static Answer fromJsonModel(Map<String, dynamic> json) => Answer.fromJson(json);
}