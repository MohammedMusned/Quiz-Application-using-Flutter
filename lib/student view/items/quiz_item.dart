// import 'package:flutter/material.dart';

// class QuizItem extends StatelessWidget {
//   final String id;
//   final String title;

//   const QuizItem({super.key, required this.id, required this.title});

//   void selectQuiz(BuildContext ctx) {
//     Navigator.of(ctx).pushNamed(
//       '/question-screen', // Route for quiz detail
//       arguments: {'id': id, 'title': title},
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => selectQuiz(context),
//       splashColor: Colors.blueAccent,
//       borderRadius: BorderRadius.circular(10),
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.blue[50],
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.blueAccent, width: 2),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.blueGrey.withOpacity(0.2),
//               blurRadius: 6,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Center(
//           child: Text(
//             title,
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.blue[900],
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class QuizItem extends StatelessWidget {
  final String id;
  final String title;
  final String sectionId; // Add sectionId

  const QuizItem({
    super.key,
    required this.id,
    required this.title,
    required this.sectionId, // Receive sectionId
  });

  void selectQuiz(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      '/question-screen', // Route to the questions screen
      arguments: {
        'sectionId': sectionId, // Pass sectionId
        'id': id, // Pass quizId
        'title': title, // Pass quiz title
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectQuiz(context),
      splashColor: Colors.blueAccent,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blueAccent, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.2),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
