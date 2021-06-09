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

  // Page.fromJson(Map<String,dynamic> json){
  //   _totalElements=json['totalElements'];
  //   _totalPages=json['totalPages'];
  //   _isFirst=json['isFirst'];
  //   _isLast=json['isLast'];
  //   _hasNext=json['hasNext'];
  //   _hasPrevious=json['hasPrevious'];
  //   var content = json['content'];
  // }
}