abstract class Encodable{
  Map<String,dynamic> toJson();
}

abstract class Decodable{
  Decodable.fromJson(Map<String,dynamic>json);
}
abstract class Codable implements Encodable,Decodable{

}