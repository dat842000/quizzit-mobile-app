import 'package:json_annotation/json_annotation.dart';
import 'package:quizzit/models/Codable.dart';

import 'QuestionSubmit.dart';

part 'QuestionInfo.g.dart';

@JsonSerializable(createFactory: false)
class QuestionInfo implements Encodable {
  int numberOfQuestion = 0;
  @JsonKey(toJson: userAnswersToJs)
  List<QuestionSubmit> userAnswers = [];
  QuestionInfo.empty();

  static List<Map<String, dynamic>> userAnswersToJs(List<QuestionSubmit> us) {
    return us.map((e) => e.toJson()).toList();
  }

  QuestionInfo(this.numberOfQuestion, this.userAnswers);

  @override
  Map<String, dynamic> toJson() => _$QuestionInfoToJson(this);
}
