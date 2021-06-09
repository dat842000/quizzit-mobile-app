import 'package:json_annotation/json_annotation.dart';
part 'ProblemDetails.g.dart';
@JsonSerializable()
class ProblemDetails {
  String? type;
  String? title;
  String? message;
  Map<String, String>? params;
  Map<String, dynamic>? errors;

  ProblemDetails(this.type, this.title, this.message, this.params, this.errors);

  factory ProblemDetails.fromJson(Map<String,dynamic> json)=>_$ProblemDetailsFromJson(json);
}