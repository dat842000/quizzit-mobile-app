import 'package:flutter_auth/models/Codable.dart';
import 'package:flutter_auth/models/question/Question.dart';
import 'package:json_annotation/json_annotation.dart';
part 'QuestionsWrapper.g.dart';

@JsonSerializable(createFactory: true,genericArgumentFactories: true)
class QuestionsWrapper<T extends Decodable> implements Decodable{
  int numberOfQuestion;
  List<Question> questions;
  int id;


  QuestionsWrapper(this.numberOfQuestion, this.questions, this.id);

  // factory QuestionsWrapper.fromJson(Map<String, dynamic> json) => _$QuestionsWrapperFromJson(json);
  // static QuestionsWrapper fromJsonModel(Map<String, dynamic> json) => QuestionsWrapper.fromJson(json);
  factory QuestionsWrapper.fromJson(Map<String,dynamic>json,Function fromJsonModel)=>_$QuestionsWrapperFromJson(json, (json) => fromJsonModel(json));
}