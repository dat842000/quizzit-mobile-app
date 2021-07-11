import 'package:json_annotation/json_annotation.dart';
import 'package:quizzit/models/Codable.dart';
import 'package:quizzit/models/answer/Answer.dart';

part 'Question.g.dart';

@JsonSerializable()
class Question implements Decodable {
  String content;
  List<Answer> answers;
  int id;
  int questionToken;

  Question(this.content, this.answers, this.id, this.questionToken);

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  static Question fromJsonModel(Map<String, dynamic> json) =>
      Question.fromJson(json);
}
