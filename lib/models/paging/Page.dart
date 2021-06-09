import '../Codable.dart';

class Page<T extends Decodable> implements Decodable{
  int _totalElements=0;
  int _totalPages=0;
  bool _isFirst=false;
  bool _isLast=false;
  bool _hasNext=false;
  bool _hasPrevious=false;
  List<T> _content=<T>[];

  Page.fromJson(Map<String,dynamic> json){
    _totalElements=json['totalElements'];
    _totalPages=json['totalPages'];
    _isFirst=json['isFirst'];
    _isLast=json['isLast'];
    _hasNext=json['hasNext'];
    _hasPrevious=json['hasPrevious'];
    var content = json['content'];

  }
}