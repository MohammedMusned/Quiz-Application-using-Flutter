// import 'package:flutter/material.dart';
// import 'package:quiz_app/servcies/quiz_service.dart';
// import 'package:quiz_app/student%20view/items/quiz_item.dart';

// class QuizScreen extends StatefulWidget {
//   @override
//   _QuizScreenState createState() => _QuizScreenState();
// }

// class _QuizScreenState extends State<QuizScreen> {
//   final QuizService _quizService = QuizService();
//   List<Map<String, dynamic>> _quizzes = [];
//   bool _isLoading = true;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _loadQuizzes();
//   }

//   Future<void> _loadQuizzes() async {
//     if (!_isLoading) return; // Ensure this runs only once
//     final routeArgs =
//         ModalRoute.of(context)!.settings.arguments as Map<String, String>;
//     final sectionId = routeArgs['id']!;
//     final sectionTitle = routeArgs['title']!;

//     try {
//       print("Fetching quizzes for section: $sectionId ($sectionTitle)");

//       List<Map<String, dynamic>> quizzes =
//           await _quizService.fetchQuizzes(sectionId);
//       print("Fetched quizzes: $quizzes");

//       setState(() {
//         _quizzes = quizzes;
//         _isLoading = false;
//       });
//     } catch (e) {
//       print('Error fetching quizzes: $e');
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final routeArgs =
//         ModalRoute.of(context)!.settings.arguments as Map<String, String>;
//     final sectionTitle = routeArgs['title']!;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(sectionTitle),
//         backgroundColor: const Color(0xff5888d8),
//       ),
//       body: _isLoading
//           ? const Center(
//               child:
//                   CircularProgressIndicator()) // Show loading indicator while fetching data
//           : _quizzes.isEmpty
//               ? const Center(child: Text('No quizzes available.'))
//               : ListView.builder(
//                   itemCount: _quizzes.length,
//                   itemBuilder: (ctx, index) {
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                       child: QuizItem(
//                         id: _quizzes[index]['id'],
//                         title: _quizzes[index]['quizName'],
//                       ),
//                     );
//                   },
//                 ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:quiz_app/servcies/quiz_service.dart';
import 'package:quiz_app/student%20view/items/quiz_item.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizService _quizService = QuizService();
  List<Map<String, dynamic>> _quizzes = [];
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadQuizzes();
  }

  Future<void> _loadQuizzes() async {
    if (!_isLoading) return; // Ensure this runs only once
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final sectionId = routeArgs['id']!;
    final sectionTitle = routeArgs['title']!;

    try {
      print("Fetching quizzes for section: $sectionId ($sectionTitle)");

      List<Map<String, dynamic>> quizzes =
          await _quizService.fetchQuizzes(sectionId);
      print("Fetched quizzes: $quizzes");

      setState(() {
        _quizzes = quizzes;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching quizzes: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final sectionTitle = routeArgs['title']!;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 11, 38, 60),
      appBar: AppBar(
        title: Text(
          sectionTitle,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 27, 92, 145),
      ),
      body: _isLoading
          ? const Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator while fetching data
          : _quizzes.isEmpty
              ? const Center(child: Text('No quizzes available.'))
              : ListView.builder(
                  itemCount: _quizzes.length,
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: QuizItem(
                        id: _quizzes[index]['id'],
                        title: _quizzes[index]['quizName'],
                        sectionId:
                            routeArgs['id']!, // Pass sectionId to QuizItem
                      ),
                    );
                  },
                ),
    );
  }
}
