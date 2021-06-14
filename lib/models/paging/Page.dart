import 'package:json_annotation/json_annotation.dart';

import '../Codable.dart';
part 'Page.g.dart';

@JsonSerializable(createFactory: true,genericArgumentFactories: true)
class Page<T extends Decodable> implements Decodable{

  int totalElements=0;
  int totalPages=0;
  bool isFirst=false;
  bool isLast=false;
  bool hasNext=false;
  bool hasPrevious=false;
  List<T> content=<T>[];


  Page(this.totalElements, this.totalPages, this.isFirst, this.isLast,
      this.hasNext, this.hasPrevious, this.content);

  factory Page.fromJson(Map<String,dynamic>json,Function fromJsonModel)=>_$PageFromJson(json, (json) => fromJsonModel(json));
}