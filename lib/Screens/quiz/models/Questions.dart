class Question {
  final int id, answer;
  final String question;
  final List<String> options;
  int _choice = -1;

  int get choice => _choice;

  set choice(int value) {
    _choice = value;
  }

  Question({required this.id, required this.question, required this.answer, required this.options});
}

