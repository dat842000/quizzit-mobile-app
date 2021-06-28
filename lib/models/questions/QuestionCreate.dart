import 'package:flutter_auth/models/Codable.dart';
import 'package:flutter_auth/models/questions/Answers.dart';
import 'package:json_annotation/json_annotation.dart';

part 'QuestionCreate.g.dart';
@JsonSerializable()
class QuestionCreate implements Codable{
  String content;
  int inSubject;
  bool? isPrivate;
  List<Answer> answers;

  QuestionCreate(this.content, this.inSubject, this.isPrivate, this.answers);

  factory QuestionCreate.fromJson(Map<String,dynamic>json)=>_$QuestionCreateFromJson(json);
  static QuestionCreate fromJsonModel(Map<String, dynamic> json) => QuestionCreate.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return _$QuestionCreateToJson(this);
  }
}