// lib/services/firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/Models/user.dart';
import 'dart:math';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Register user in Firestore
  Future<void> registerUser(User user, String userType) async {
    try {
      // Add user to Firestore collection
      await _db.collection('users').doc(user.username).set({
        'name': user.name,
        'username': user.username,
        'password': user.password,
        'userType': userType,
      });
    } catch (e) {
      throw Exception("Error registering user: $e");
    }
  }

  // Future<String> login(String username, String password) async {
  //   try {
  //     final userDoc = await _db.collection('users').doc(username).get();

  //     if (!userDoc.exists) {
  //       return 'User not found';
  //     }

  //     final userData = userDoc.data()!;
  //     final storedPassword = userData['password'];
  //     final userType = userData['userType'];

  //     // Check if the entered password matches the stored password
  //     if (storedPassword == password) {
  //       return userType; // Return the userType (Student or Teacher)
  //     } else {
  //       return 'Incorrect password';
  //     }
  //   } catch (e) {
  //     return 'Error: $e';
  //   }
  // }

  String currentUsername = '';
  Future<String> login(String username, String password) async {
    try {
      final userDoc = await _db.collection('users').doc(username).get();

      if (!userDoc.exists) {
        return 'User not found';
      }

      final userData = userDoc.data()!;
      final storedPassword = userData['password'];
      final userType = userData['userType'];

      // Check if the entered password matches the stored password
      if (storedPassword == password) {
        currentUsername = username; // Set the current logged-in user
        return userType; // Return the userType (Student or Teacher)
      } else {
        return 'Incorrect password';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  // Save score with a random student ID
  Future<void> saveStudentScore(
      int score, String sectionId, String quizId) async {
    try {
      // Generate a random student ID
      String randomStudentId =
          Random().nextInt(1000000).toString(); // Generates a random student ID

      // Create a new document in the 'student_scores' collection with a random ID
      await _db.collection('student_scores').add({
        'score': score, // Score for this quiz
        'quizId': quizId, // Quiz ID
        'sectionId': sectionId, // Section ID
        'timestamp':
            FieldValue.serverTimestamp(), // Store the current timestamp
        'totalQuestions':
            10, // Adjust based on the number of questions in the quiz
        'studentId': randomStudentId, // Store the random student ID
      });

      print('Score saved successfully with studentId: $randomStudentId');
    } catch (e) {
      print('Error saving score: $e');
      // Handle the error here, like showing an error message to the user
    }
  }
}
