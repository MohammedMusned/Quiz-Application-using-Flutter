// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class QuestionsScreen extends StatefulWidget {
//   const QuestionsScreen({super.key});

//   @override
//   _QuestionsScreenState createState() => _QuestionsScreenState();
// }

// class _QuestionsScreenState extends State<QuestionsScreen> {
//   late String sectionId;
//   late String quizId;
//   late String quizTitle;
//   bool isLoading = true;
//   List<Map<String, dynamic>> questions = [];
//   Map<int, int?> selectedAnswers = {};

//   // Fetch questions from Firestore
//   Future<void> fetchQuestions(String sectionId, String quizId) async {
//     try {
//       final querySnapshot = await FirebaseFirestore.instance
//           .collection('sections')
//           .doc(sectionId)
//           .collection('quizzes')
//           .doc(quizId)
//           .collection('questions')
//           .get();

//       if (querySnapshot.docs.isEmpty) {
//         print('No questions found for this quiz.');
//       }

//       final loadedQuestions = querySnapshot.docs.map((doc) {
//         print('Question fetched: ${doc.data()}');
//         return {
//           'id': doc.id,
//           'question': doc['question'],
//           'choices': List<String>.from(doc['choices']),
//           'correctOption': doc['correctOption'],
//         };
//       }).toList();

//       setState(() {
//         questions = loadedQuestions;
//         isLoading = false;
//       });
//     } catch (e) {
//       print('Error fetching questions: $e');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final routeArgs =
//         ModalRoute.of(context)!.settings.arguments as Map<String, String>;

//     sectionId = routeArgs['sectionId']!;
//     quizId = routeArgs['id']!;
//     quizTitle = routeArgs['title']!;

//     print('Fetching questions for section: $sectionId, quiz: $quizId');

//     fetchQuestions(sectionId, quizId);
//   }

//   // Calculate score
//   int calculateScore() {
//     int score = 0;
//     for (var i = 0; i < questions.length; i++) {
//       if (selectedAnswers[i] == questions[i]['correctOption']) {
//         score++;
//       }
//     }
//     return score;
//   }

//   // // Show results
//   // void showResults() {
//   //   final score = calculateScore();
//   //   showDialog(
//   //     context: context,
//   //     builder: (ctx) {
//   //       return AlertDialog(
//   //         title: const Text('Quiz Finished'),
//   //         content: Text('Your score is: $score/${questions.length}'),
//   //         actions: [
//   //           TextButton(
//   //             onPressed: () {
//   //               Navigator.of(ctx).pop();
//   //               Navigator.of(context).pop(); // Go back to previous screen
//   //             },
//   //             child: const Text('OK'),
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }
//   void showResults() async {
//     final score = calculateScore();
//     final totalQuestions = questions.length;

//     try {
//       // Save the score to Firestore
//       await FirebaseFirestore.instance
//           .collection('student_scores') // Collection to store scores
//           .add({
//         'studentId': '12345', // Replace with actual student ID
//         'quizId': quizId,
//         'sectionId': sectionId,
//         'score': score,
//         'totalQuestions': totalQuestions,
//         'timestamp': Timestamp.now(),
//       });

//       showDialog(
//         context: context,
//         builder: (ctx) {
//           return AlertDialog(
//             title: const Text('Quiz Finished'),
//             content: Text('Your score is: $score/$totalQuestions'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(ctx).pop();
//                   Navigator.of(context).pop(); // Go back to previous screen
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     } catch (e) {
//       print('Error saving score: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text('Failed to save score. Please try again.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 11, 38, 60),
//       appBar: AppBar(
//         title: Text(
//           '$quizTitle Questions',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Color.fromARGB(255, 27, 92, 145),
//       ),
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator()) // Loading indicator
//           : questions.isEmpty
//               ? const Center(
//                   child: Text('No questions available.')) // No questions
//               : Column(
//                   children: [
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: questions.length,
//                         itemBuilder: (ctx, index) {
//                           final question = questions[index];
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8),
//                             child: Card(
//                               color: const Color.fromARGB(255, 97, 130, 156),
//                               elevation: 4,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       question['question'],
//                                       style: const TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     const SizedBox(height: 8),
//                                     ...List.generate(
//                                       question['choices'].length,
//                                       (choiceIndex) {
//                                         return RadioListTile<int>(
//                                           value: choiceIndex,
//                                           groupValue: selectedAnswers[
//                                               index], // Track selected option
//                                           onChanged: (value) {
//                                             setState(() {
//                                               selectedAnswers[index] =
//                                                   value; // Update selection
//                                             });
//                                           },
//                                           title: Text(
//                                               question['choices'][choiceIndex]),
//                                         );
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: TextButton(
//                         onPressed: showResults,
//                         style: TextButton.styleFrom(
//                           padding: const EdgeInsets.all(0),
//                         ),
//                         child: Container(
//                           width: 100,
//                           height: 50,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(15),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.shade600,
//                                 blurRadius: 10,
//                                 offset: const Offset(2, 4),
//                               ),
//                             ],
//                           ),
//                           alignment: Alignment.center,
//                           child: Text(
//                             'Submit',
//                             style: const TextStyle(
//                               color: Color.fromARGB(255, 9, 56, 94),
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/servcies/user_service.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late String sectionId;
  late String quizId;
  late String quizTitle;
  bool isLoading = true;
  List<Map<String, dynamic>> questions = [];
  Map<int, int?> selectedAnswers = {};
  final UserService _authService = UserService();

  // Fetch questions from Firestore
  Future<void> fetchQuestions(String sectionId, String quizId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('sections')
          .doc(sectionId)
          .collection('quizzes')
          .doc(quizId)
          .collection('questions')
          .get();

      if (querySnapshot.docs.isEmpty) {
        print('No questions found for this quiz.');
      }

      final loadedQuestions = querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'question': doc['question'],
          'choices': List<String>.from(doc['choices']),
          'correctOption': doc['correctOption'],
        };
      }).toList();

      setState(() {
        questions = loadedQuestions;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching questions: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    sectionId = routeArgs['sectionId']!;
    quizId = routeArgs['id']!;
    quizTitle = routeArgs['title']!;

    fetchQuestions(sectionId, quizId);
  }

  // Calculate score
  int calculateScore() {
    int score = 0;
    for (var i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i]['correctOption']) {
        score++;
      }
    }
    return score;
  }

  // Show results
  void showResults() {
    final score = calculateScore();
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Quiz Finished'),
          content: Text('Your score is: $score/${questions.length}'),
          actions: [
            TextButton(
              onPressed: () async {
                // Save score to Firestore after quiz completion
                await _authService.saveStudentScore(score, sectionId, quizId);

                Navigator.of(ctx).pop();
                Navigator.of(context).pop(); // Go back to previous screen
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 11, 38, 60),
      appBar: AppBar(
        title: Text(
          '$quizTitle Questions',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 27, 92, 145),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : questions.isEmpty
              ? const Center(child: Text('No questions available.'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: questions.length,
                        itemBuilder: (ctx, index) {
                          final question = questions[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Card(
                              color: const Color.fromARGB(255, 97, 130, 156),
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      question['question'],
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    ...List.generate(
                                      question['choices'].length,
                                      (choiceIndex) {
                                        return RadioListTile<int>(
                                          value: choiceIndex,
                                          groupValue: selectedAnswers[index],
                                          onChanged: (value) {
                                            setState(() {
                                              selectedAnswers[index] = value;
                                            });
                                          },
                                          title: Text(
                                              question['choices'][choiceIndex]),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextButton(
                        onPressed: showResults,
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0)),
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade600,
                                blurRadius: 10,
                                offset: const Offset(2, 4),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Submit',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 11, 38, 60),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
