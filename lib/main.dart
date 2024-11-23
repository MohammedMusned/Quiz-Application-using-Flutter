import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/student%20view/screens/quiz_catogry_screen.dart';

import 'package:quiz_app/student%20view/screens/quiz_screen.dart';
import 'package:quiz_app/student%20view/screens/test_screen.dart';

import 'package:quiz_app/teacher%20view/delete_quiz_screen.dart';
import 'package:quiz_app/teacher%20view/login_screen.dart';

import 'package:quiz_app/teacher%20view/quiz_set_up_screen.dart';
import 'package:quiz_app/teacher%20view/sign_up.dart';
import 'package:quiz_app/teacher%20view/teacher_screen.dart';

import 'package:quiz_app/teacher%20view/view_results_page.dart';

// void main() {
//   runApp(const MyApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => LoginForm(),
        // '/': (context) => CategoryScreen(),

        '/sign-up': (context) => RegistrationForm(),
        '/student-screen': (ctx) => CategoryScreen(),
        '/teacher-screen': (ctx) => TeacherScreen(),
        '/quiz-screet': (context) => QuizSetupScreen(),
        '/dquiz.screen': (context) => DeleteQuizScreen(),
        '/res.screen': (context) => ResultsScreen(),
        '/quizs-screen': (context) => QuizScreen(),
        '/question-screen': (context) => QuestionsScreen(),
      },
    );
  }
}
