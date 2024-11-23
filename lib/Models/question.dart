class Question {
  String question;
  List<String> choices;
  int correctOption;

  Question({
    required this.question,
    required this.choices,
    required this.correctOption,
  });

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'choices': choices,
      'correctOption': correctOption,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      question: map['question'],
      choices: List<String>.from(map['choices']),
      correctOption: map['correctOption'],
    );
  }
}
