import 'package:json_annotation/json_annotation.dart';
import 'package:quizzit/models/Codable.dart';

part 'Answers.g.dart';

@JsonSerializable()
class Answer implements Codable {
  int id;
  String content;
  bool isCorrect;

  Answer(this.id, this.content, this.isCorrect);

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);
  static Answer fromJsonModel(Map<String, dynamic> json) =>
      Answer.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return _$AnswerToJson(this);
  }
}
