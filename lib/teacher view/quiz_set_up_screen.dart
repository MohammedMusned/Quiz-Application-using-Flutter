import 'package:flutter/material.dart';
import 'package:quiz_app/servcies/quiz_service.dart';
import 'package:quiz_app/teacher%20view/add_questions_screen.dart';

class QuizSetupScreen extends StatefulWidget {
  const QuizSetupScreen({super.key});

  @override
  _QuizSetupScreenState createState() => _QuizSetupScreenState();
}

class _QuizSetupScreenState extends State<QuizSetupScreen> {
  String? selectedSection;
  String quizName = '';
  int? numberOfQuestions;
  final QuizService _quizService = QuizService();

  final List<String> sections = [
    'Mathematics',
    'Science',
    'Arabic',
    'History',
    'Geography',
    'Physics',
    'Chemistry',
    'Biology',
    'Computer Science',
    'English Literature',
    'Economics'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 11, 38, 60),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 92, 145),
        title: const Text(
          'Quiz Setup',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Section:',
              style: TextStyle(color: Colors.white), // Label text in white
            ),
            DropdownButton<String>(
              value: selectedSection,
              isExpanded: true,
              hint: const Text(
                'Choose a section',
                style: TextStyle(color: Colors.white), // Hint text in white
              ),
              dropdownColor:
                  const Color.fromARGB(255, 27, 92, 145), // Dropdown background
              items: sections.map((section) {
                return DropdownMenuItem(
                  value: section,
                  child: Text(
                    section,
                    style: const TextStyle(
                        color: Colors.white), // Dropdown item text in white
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSection = value;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Quiz Name:',
              style: TextStyle(color: Colors.white), // Label text in white
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  quizName = value;
                });
              },
              style:
                  const TextStyle(color: Colors.white), // Input text in white
              decoration: const InputDecoration(
                hintText: 'Enter the quiz name',
                hintStyle: TextStyle(
                    color:
                        Colors.white54), // Hint text in white with transparency
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.white), // Border in white
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.amber), // Highlighted border color
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Number of Questions:',
              style: TextStyle(color: Colors.white), // Label text in white
            ),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  numberOfQuestions = int.tryParse(value);
                });
              },
              style:
                  const TextStyle(color: Colors.white), // Input text in white
              decoration: const InputDecoration(
                hintText: 'Enter the number of questions',
                hintStyle: TextStyle(
                    color:
                        Colors.white54), // Hint text in white with transparency
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.white), // Border in white
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.amber), // Highlighted border color
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                if (selectedSection != null &&
                    numberOfQuestions != null &&
                    quizName.isNotEmpty) {
                  // Create the quiz without adding questions initially
                  String quizId = await _quizService
                      .createQuiz(selectedSection!, quizName, []);

                  // Navigate to the AddQuestionsScreen and pass the quizId
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddQuestionsScreen(
                        section: selectedSection!,
                        numberOfQuestions: numberOfQuestions!,
                        quizId:
                            quizId, // Passing the quizId to AddQuestionsScreen
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields')),
                  );
                }
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
