import 'package:json_annotation/json_annotation.dart';
import 'package:quizzit/models/Codable.dart';

part 'Subject.g.dart';

@JsonSerializable()
class Subject implements Decodable {
  int id;
  String name;

  Subject(this.id, this.name);

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);
}
