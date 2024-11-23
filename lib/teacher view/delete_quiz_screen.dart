import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteQuizScreen extends StatefulWidget {
  const DeleteQuizScreen({super.key});

  @override
  _DeleteQuizScreenState createState() => _DeleteQuizScreenState();
}

class _DeleteQuizScreenState extends State<DeleteQuizScreen> {
  String? selectedQuiz; // Holds the selected quiz ID
  List<Map<String, dynamic>> quizzes = []; // Holds quiz details (ID and name)

  @override
  void initState() {
    super.initState();
    fetchQuizzes();
  }

  /// Fetch quizzes from Firestore
  Future<void> fetchQuizzes() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collectionGroup('quizzes') // Adjust collection path if needed
          .get();

      final fetchedQuizzes = querySnapshot.docs
          .map((doc) => {
                'id': doc.id,
                'name': doc.data()['name'] ?? 'Unnamed Quiz',
              })
          .toList();

      setState(() {
        quizzes = fetchedQuizzes;
      });
    } catch (e) {
      print('Error fetching quizzes: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load quizzes.')),
      );
    }
  }

  /// Delete a selected quiz from Firestore
  Future<void> deleteQuiz(String quizId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collectionGroup('quizzes') // Adjust collection path if needed
          .where(FieldPath.documentId, isEqualTo: quizId)
          .get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Quiz deleted successfully.')),
      );

      // Refresh the quiz list
      fetchQuizzes();
    } catch (e) {
      print('Error deleting quiz: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete quiz.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 11, 38, 60),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 92, 145),
        title: const Text(
          'Delete Quiz',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: quizzes.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select a Quiz to Delete:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedQuiz,
                    hint: const Text(
                      'Choose a quiz',
                      style: TextStyle(color: Colors.white),
                    ),
                    dropdownColor: const Color.fromARGB(255, 27, 92, 145),
                    items: quizzes.map((quiz) {
                      return DropdownMenuItem<String>(
                        value: quiz['id']
                            as String, // Ensure quiz['id'] is a String
                        child: Text(
                          quiz['name']
                              as String, // Ensure quiz['name'] is a String
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedQuiz = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 27, 92, 145),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: selectedQuiz == null
                        ? null
                        : () => deleteQuiz(selectedQuiz!),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: selectedQuiz == null
                          ? Colors.grey
                          : const Color(0xffd3170a),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Delete Quiz',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (quizzes.isEmpty)
                    const Text(
                      'No quizzes available.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
      ),
    );
  }
}
