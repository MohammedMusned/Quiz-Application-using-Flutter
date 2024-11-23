import 'package:flutter/material.dart';
import 'package:quiz_app/servcies/user_service.dart';
// Import the UserService

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _enteredUserName = TextEditingController();
  final TextEditingController _enteredPassword = TextEditingController();
  final UserService _userService = UserService(); // Initialize UserService

  Future<void> _login() async {
    final username = _enteredUserName.text;
    final password = _enteredPassword.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter both username and password')),
      );
      return;
    }

    final result = await _userService.login(username, password);

    if (result == 'User not found' || result == 'Incorrect password') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
      return;
    }

    // Navigate based on user type
    if (result == 'Student') {
      Navigator.pushNamed(context, '/student-screen');
    } else if (result == 'Teacher') {
      Navigator.pushNamed(context, '/teacher-screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 11, 38, 60),
        body: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'images/letter-q.png',
                    height: 150,
                  ),
                  SizedBox(height: 100),
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      children: [
                        const Text(
                          textAlign: TextAlign.center,
                          'Please fill out the form below to get started',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          controller: _enteredUserName,
                          decoration: InputDecoration(
                            label: Text(
                              'username',
                              style: TextStyle(
                                color: Colors.blue[200],
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.person_2,
                              color: Colors.blue[200],
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          controller: _enteredPassword,
                          decoration: InputDecoration(
                            label: Text(
                              'password',
                              style: TextStyle(
                                color: Colors.blue[200],
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.blue[200],
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: 200,
                          child: TextButton(
                            onPressed: _login,
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[900],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            // Navigate to the registration screen
                            Navigator.pushNamed(context, '/sign-up');
                            print("Navigate to Register Screen");
                          },
                          child: const Text(
                            "Don't have an account? Register here",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
