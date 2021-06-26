import 'package:flutter_auth/models/Codable.dart';
import 'package:flutter_auth/models/questions/Answers.dart';
import 'package:flutter_auth/models/user/BaseUser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Question.g.dart';
@JsonSerializable()
class Question implements Decodable{
  int id;
  String content;
  int inSubject;
  DateTime updateAt;
  BaseUser createdBy;
  bool isPrivate;
  bool isAdd;
  List<Answer> answers;

  Question(this.id, this.content, this.inSubject, this.updateAt, this.createdBy,
      this.isPrivate, this.isAdd, this.answers);

  factory Question.fromJson(Map<String,dynamic>json)=>_$QuestionFromJson(json);
  static Question fromJsonModel(Map<String, dynamic> json) => Question.fromJson(json);
}