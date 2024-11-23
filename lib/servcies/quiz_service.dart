import 'package:cloud_firestore/cloud_firestore.dart';

class QuizService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Future<void> createQuiz(
  //     String section, String quizName, List<Question> questions) async {
  //   try {
  //     CollectionReference sectionsRef = _db.collection('sections');
  //     DocumentReference sectionRef = sectionsRef.doc(section);

  //     CollectionReference quizzesRef = sectionRef.collection('quizzes');
  //     DocumentReference quizRef = await quizzesRef.add({
  //       'quizName': quizName,
  //       'section': section,
  //     });

  //     print('Quiz created with ID: ${quizRef.id}'); // Debug print

  //     // Add questions to the quiz's sub-collection
  //     CollectionReference questionsRef = quizRef.collection('questions');
  //     for (var question in questions) {
  //       print('Adding question: ${question.toMap()}'); // Debug print
  //       await questionsRef.add(question.toMap());
  //     }

  //     print('All questions added for quiz ID: ${quizRef.id}');
  //   } catch (e) {
  //     print('Error creating quiz: $e');
  //   }
  // }

  // Create a quiz and return the quizId
  Future<String> createQuiz(
      String section, String quizName, List<dynamic> questions) async {
    try {
      // Create a new document for the quiz
      DocumentReference quizRef = await FirebaseFirestore.instance
          .collection('sections')
          .doc(section)
          .collection('quizzes')
          .add({
        'quizName': quizName,
        'questions': questions, // Add questions, if any
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Return the quizId
      return quizRef.id;
    } catch (e) {
      print('Error creating quiz: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> fetchQuizzes(String sectionId) async {
    try {
      // Get the 'quizzes' collection for the specific section
      QuerySnapshot snapshot = await _db
          .collection('sections')
          .doc(sectionId)
          .collection('quizzes')
          .get();

      // Map the documents to a list of maps (quizId and quizName)
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'quizName': doc[
              'quizName'], // Assuming quizName is a field in the quiz document
        };
      }).toList();
    } catch (e) {
      print('Error fetching quizzes: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchQuestions(
      String sectionId, String quizId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('sections') // Access the sections collection
          .doc(sectionId) // Specify the section ID
          .collection('quizzes') // Access quizzes under the section
          .doc(quizId) // Specify the quiz ID
          .collection('questions') // Access questions under the quiz
          .get();

      return querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'question': doc['question'], // Assuming 'question' field exists
          'choices': List<String>.from(
              doc['choices']), // Assuming 'choices' field is a list
          'correctAnswer':
              doc['correctAnswer'], // Assuming 'correctAnswer' exists
        };
      }).toList();
    } catch (e) {
      print('Error fetching questions: $e');
      return [];
    }
  }
}
