import 'package:json_annotation/json_annotation.dart';
import 'package:quizzit/models/Codable.dart';

part 'AnswerResult.g.dart';

@JsonSerializable()
class AnswerResult implements Decodable {
  String question;
  String answer;
  bool isCorrect;

  AnswerResult(this.question, this.answer, this.isCorrect);

  factory AnswerResult.fromJson(Map<String, dynamic> json) =>
      _$AnswerResultFromJson(json);
  static AnswerResult fromJsonModel(Map<String, dynamic> json) =>
      AnswerResult.fromJson(json);
}
