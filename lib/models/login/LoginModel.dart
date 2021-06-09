class LoginRequest {
  String _username="";
  String _password="";

  Map<String, String> toJson() =>
      {'username': _username, 'password': _password};

  String get password => _password;

  String get username => _username;
}