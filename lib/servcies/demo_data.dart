final demoCategories = [
  {'id': '1', 'title': 'Math', 'imageAsset': 'images/student (1).png'},
  {'id': '2', 'title': 'Science', 'imageAsset': 'images/student (1).png'},
  {'id': '3', 'title': 'History', 'imageAsset': 'images/student (1).png'},
];

final demoQuizzes = [
  {'id': '1', 'categoryId': '1', 'title': 'Basic Math Quiz'},
  {'id': '2', 'categoryId': '1', 'title': 'Advanced Math Quiz'},
  {'id': '3', 'categoryId': '2', 'title': 'Physics Quiz'},
  {'id': '4', 'categoryId': '2', 'title': 'Chemistry Quiz'},
  {'id': '5', 'categoryId': '3', 'title': 'Ancient History Quiz'},
  {'id': '6', 'categoryId': '3', 'title': 'Modern History Quiz'},
];

// demo_questions.dart
const List<Map<String, dynamic>> demoQuestions = [
  {
    'question': 'What is 2 + 2?',
    'choices': ['3', '4', '5', '6'],
    'correctAnswer': 1, // Index of '4'
  },
  {
    'question': 'What is the capital of France?',
    'choices': ['Berlin', 'Madrid', 'Paris', 'Rome'],
    'correctAnswer': 2, // Index of 'Paris'
  },
  {
    'question': 'Which planet is known as the Red Planet?',
    'choices': ['Earth', 'Mars', 'Jupiter', 'Venus'],
    'correctAnswer': 1, // Index of 'Mars'
  },
];
