import 'package:json_annotation/json_annotation.dart';

import '../Codable.dart';
part 'ProblemDetails.g.dart';
@JsonSerializable()
class ProblemDetails implements Decodable{
  String? type;
  String? title;
  String? message;
  Map<String, String>? params;
  Map<String, dynamic>? errors;

  ProblemDetails(this.type, this.title, this.message, this.params, this.errors);

  factory ProblemDetails.fromJson(Map<String,dynamic> json)=>_$ProblemDetailsFromJson(json);
}