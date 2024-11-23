import 'package:quiz_app/Models/question.dart';

class Quiz {
  String section;
  String quizName;
  List<Question> questions;

  Quiz({
    required this.section,
    required this.quizName,
    required this.questions,
  });

  Map<String, dynamic> toMap() {
    return {
      'section': section,
      'quizName': quizName,
      'questions': questions.map((question) => question.toMap()).toList(),
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      section: map['section'],
      quizName: map['quizName'],
      questions:
          List<Question>.from(map['questions'].map((x) => Question.fromMap(x))),
    );
  }
}
