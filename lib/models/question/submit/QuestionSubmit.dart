import 'package:json_annotation/json_annotation.dart';
import 'package:quizzit/models/Codable.dart';

part 'QuestionSubmit.g.dart';

@JsonSerializable(createFactory: false)
class QuestionSubmit implements Encodable {
  int questionId;
  int questionToken;
  int answerId;

  QuestionSubmit(this.questionId, this.questionToken, this.answerId);

  @override
  Map<String, dynamic> toJson() => _$QuestionSubmitToJson(this);
}
