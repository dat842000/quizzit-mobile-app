import 'package:flutter_auth/models/subject/Subject.dart';
import 'package:flutter_auth/models/Codable.dart';
import 'package:flutter_auth/models/answer/Answer.dart';
import 'package:json_annotation/json_annotation.dart';
part 'QuestionSubmit.g.dart';
@JsonSerializable()
class QuestionSubmit implements Encodable{
  int id;
  int questionToken;
  int answerId;


  QuestionSubmit(this.id, this.questionToken, this.answerId);


  @override
  String toString() {
    return 'QuestionSubmit{id: $id, questionToken: $questionToken, answerId: $answerId}';
  }

  @override
  Map<String, dynamic> toJson() => _$QuestionSubmitToJson(this);
}