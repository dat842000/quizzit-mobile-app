class ProblemDetails {
  String _type;
  String _title;
  String _message;
  Map<String, String>? _params;
  Map<String, dynamic>? _errors;

  ProblemDetails.fromJson(Map<String, dynamic> json)
      : _type = json['type'],
        _title = json['title'],
        _message = json['message'],
        _params = json['params'],
        _errors = json['errors'];

  Map<String, dynamic>? get errors => _errors;

  Map<String, String>? get params => _params;

  String get message => _message;

  String get title => _title;

  String get type => _type;
}