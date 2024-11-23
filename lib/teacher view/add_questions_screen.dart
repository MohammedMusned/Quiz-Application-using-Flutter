import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddQuestionsScreen extends StatefulWidget {
  final String section;
  final int numberOfQuestions;
  final String quizId;

  const AddQuestionsScreen({
    super.key,
    required this.section,
    required this.numberOfQuestions,
    required this.quizId,
  });

  @override
  _AddQuestionsScreenState createState() => _AddQuestionsScreenState();
}

class _AddQuestionsScreenState extends State<AddQuestionsScreen> {
  List<Map<String, dynamic>> questions = [];

  @override
  void initState() {
    super.initState();
    questions = List.generate(
      widget.numberOfQuestions,
      (_) => {
        'question': '',
        'choices': List<String>.filled(4, ''),
        'correctOption': 0,
      },
    );
  }

  Future<void> saveQuestions() async {
    final batch = FirebaseFirestore.instance.batch();

    for (var question in questions) {
      final questionRef = FirebaseFirestore.instance
          .collection('sections')
          .doc(widget.section)
          .collection('quizzes')
          .doc(widget.quizId)
          .collection('questions')
          .doc();

      batch.set(questionRef, {
        'question': question['question'],
        'choices': question['choices'],
        'correctOption': question['correctOption'],
      });
    }

    try {
      await batch.commit();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Questions saved successfully!')),
      );
    } catch (e) {
      print('Error saving questions: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save questions')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 11, 38, 60),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 92, 145),
        title: Text(
          'Add Questions (${widget.section})',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.numberOfQuestions,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question ${index + 1}:',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                onChanged: (value) {
                  questions[index]['question'] = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter the question',
                  hintStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 27, 92, 145),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),
              ...List.generate(4, (choiceIndex) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            questions[index]['choices'][choiceIndex] = value;
                          },
                          decoration: InputDecoration(
                            hintText: 'Choice ${choiceIndex + 1}',
                            hintStyle: const TextStyle(color: Colors.white70),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 27, 92, 145),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Radio<int>(
                        value: choiceIndex,
                        groupValue: questions[index]['correctOption'],
                        onChanged: (value) {
                          setState(() {
                            questions[index]['correctOption'] = value!;
                          });
                        },
                        activeColor: const Color(0xff58d88d),
                      ),
                    ],
                  ),
                );
              }),
              Text(
                'Correct Option: Choice ${questions[index]['correctOption'] + 1}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              const Divider(color: Colors.white70),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: saveQuestions, // Call save function when pressed
        backgroundColor: const Color(0xff27ae60), // Green color
        child: const Icon(
          Icons.check, // Check icon
          color: Colors.white, // White icon color for contrast
        ),
      ),
    );
  }
}
