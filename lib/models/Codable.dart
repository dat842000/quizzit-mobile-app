abstract class Encodable{
  Map<String,dynamic> toJson();
}

abstract class Decodable{
}
abstract class Codable implements Encodable,Decodable{

}