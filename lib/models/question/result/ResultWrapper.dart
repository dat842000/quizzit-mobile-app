import 'package:json_annotation/json_annotation.dart';
import 'package:quizzit/models/Codable.dart';
import 'package:quizzit/models/user/BaseUser.dart';

part 'ResultWrapper.g.dart';

@JsonSerializable(createFactory: true, genericArgumentFactories: true)
class ResultWrapper<T extends Decodable> implements Decodable {
  int id;
  int numberOfQuestion;
  int numberOfCorrectAnswer;
  String answerAt;
  BaseUser answerBy;

  ResultWrapper(this.id, this.numberOfQuestion, this.numberOfCorrectAnswer,
      this.answerAt, this.answerBy);

  factory ResultWrapper.fromJson(
          Map<String, dynamic> json, Function fromJsonModel) =>
      _$ResultWrapperFromJson(json, (json) => fromJsonModel(json));
}
