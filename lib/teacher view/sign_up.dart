// import 'package:flutter/material.dart';

// class RegistrationForm extends StatefulWidget {
//   const RegistrationForm({super.key});

//   @override
//   _RegistrationFormState createState() => _RegistrationFormState();
// }

// class _RegistrationFormState extends State<RegistrationForm> {
//   final TextEditingController _enteredName = TextEditingController();
//   final TextEditingController _enteredUserName = TextEditingController();
//   final TextEditingController _enteredPassword = TextEditingController();
//   String userType = ''; // Track the user type (Student or Teacher)

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: const Color.fromARGB(255, 11, 38, 60),
//         body: Center(
//           child: SafeArea(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Image.asset(
//                     'images/letter-q.png',
//                     height: 150,
//                   ),
//                   SizedBox(height: 30),
//                   const Text(
//                     'Create Account',
//                     style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     'Please select your user type and register',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.blue,
//                     ),
//                   ),
//                   SizedBox(height: 30),

//                   // User type selection (Student or Teacher)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Student button
//                       IconButton(
//                         icon: Icon(Icons.person),
//                         color:
//                             userType == 'Student' ? Colors.blue : Colors.white,
//                         onPressed: () {
//                           setState(() {
//                             userType = 'Student';
//                           });
//                         },
//                         iconSize: 40,
//                       ),
//                       Text(
//                         'Student',
//                         style: TextStyle(
//                           color: userType == 'Student'
//                               ? Colors.blue
//                               : Colors.white,
//                           fontSize: 18,
//                         ),
//                       ),
//                       const SizedBox(width: 20),
//                       // Teacher button
//                       IconButton(
//                         icon: Icon(Icons.school),
//                         color:
//                             userType == 'Teacher' ? Colors.blue : Colors.white,
//                         onPressed: () {
//                           setState(() {
//                             userType = 'Teacher';
//                           });
//                         },
//                         iconSize: 40,
//                       ),
//                       Text(
//                         'Teacher',
//                         style: TextStyle(
//                           color: userType == 'Teacher'
//                               ? Colors.blue
//                               : Colors.white,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 30),

//                   // Registration form fields
//                   Padding(
//                     padding: const EdgeInsets.all(13.0),
//                     child: Column(
//                       children: [
//                         // Full Name field
//                         TextField(
//                           controller: _enteredName,
//                           style: const TextStyle(
//                               color: Colors.white, fontSize: 20),
//                           decoration: InputDecoration(
//                             label: Text('Full Name',
//                                 style: TextStyle(color: Colors.blue[200])),
//                             prefixIcon:
//                                 Icon(Icons.person, color: Colors.blue[200]),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(
//                                   color: Colors.white, width: 2),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(color: Colors.red),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),

//                         // Username field
//                         TextField(
//                           controller: _enteredUserName,
//                           style: const TextStyle(
//                               color: Colors.white, fontSize: 20),
//                           decoration: InputDecoration(
//                             label: Text('Username',
//                                 style: TextStyle(color: Colors.blue[200])),
//                             prefixIcon:
//                                 Icon(Icons.person_2, color: Colors.blue[200]),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(
//                                   color: Colors.white, width: 2),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(color: Colors.red),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),

//                         // Password field
//                         TextField(
//                           controller: _enteredPassword,
//                           obscureText: true,
//                           style: const TextStyle(
//                               color: Colors.white, fontSize: 20),
//                           decoration: InputDecoration(
//                             label: Text('Password',
//                                 style: TextStyle(color: Colors.blue[200])),
//                             prefixIcon:
//                                 Icon(Icons.lock, color: Colors.blue[200]),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(
//                                   color: Colors.white, width: 2),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               borderSide: const BorderSide(color: Colors.red),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 30),

//                         // Register button
//                         SizedBox(
//                           width: 200,
//                           child: TextButton(
//                             onPressed: () {
//                               // Handle registration functionality here
//                               if (_enteredName.text.isEmpty ||
//                                   _enteredUserName.text.isEmpty ||
//                                   _enteredPassword.text.isEmpty) {
//                                 // Show error if fields are empty
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     content: Text('Please fill in all fields'),
//                                   ),
//                                 );
//                               } else {
//                                 // Registration logic (based on userType)
//                                 print('Registered as $userType');
//                               }
//                             },
//                             style: TextButton.styleFrom(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               backgroundColor: Colors.white,
//                             ),
//                             child: Text(
//                               'Register',
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.blue[900],
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 20),

//                         // Login link
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pushNamed(context, '/');
//                             print("Navigate to Login Screen");
//                           },
//                           child: const Text(
//                             "Already have an account? Login here",
//                             style: TextStyle(
//                               color: Colors.blue,
//                               fontSize: 16,
//                               decoration: TextDecoration.underline,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// lib/screens/registration_screen.dart
import 'package:flutter/material.dart';

import 'package:quiz_app/Models/user.dart';
import 'package:quiz_app/servcies/user_service.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController _enteredName = TextEditingController();
  final TextEditingController _enteredUserName = TextEditingController();
  final TextEditingController _enteredPassword = TextEditingController();
  String userType = ''; // Track the user type (Student or Teacher)

  final UserService _firestoreService = UserService();

  // Registration method to save user data in Firestore
  Future<void> _register() async {
    final name = _enteredName.text;
    final username = _enteredUserName.text;
    final password = _enteredPassword.text;

    if (name.isEmpty ||
        username.isEmpty ||
        password.isEmpty ||
        userType.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    // Create a user model
    final user = User(name: name, username: username, password: password);

    try {
      // Register the user in Firestore
      await _firestoreService.registerUser(user, userType);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User registered successfully')),
      );

      // Navigate to login screen after successful registration
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error registering user: $e')),
      );
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
                  SizedBox(height: 30),
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Please select your user type and register',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 30),

                  // User type selection (Student or Teacher)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Student button
                      IconButton(
                        icon: Icon(Icons.person),
                        color:
                            userType == 'Student' ? Colors.blue : Colors.white,
                        onPressed: () {
                          setState(() {
                            userType = 'Student';
                          });
                        },
                        iconSize: 40,
                      ),
                      Text(
                        'Student',
                        style: TextStyle(
                          color: userType == 'Student'
                              ? Colors.blue
                              : Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Teacher button
                      IconButton(
                        icon: Icon(Icons.school),
                        color:
                            userType == 'Teacher' ? Colors.blue : Colors.white,
                        onPressed: () {
                          setState(() {
                            userType = 'Teacher';
                          });
                        },
                        iconSize: 40,
                      ),
                      Text(
                        'Teacher',
                        style: TextStyle(
                          color: userType == 'Teacher'
                              ? Colors.blue
                              : Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Registration form fields
                  Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Column(
                      children: [
                        // Full Name field
                        TextField(
                          controller: _enteredName,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          decoration: InputDecoration(
                            label: Text('Full Name',
                                style: TextStyle(color: Colors.blue[200])),
                            prefixIcon:
                                Icon(Icons.person, color: Colors.blue[200]),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Username field
                        TextField(
                          controller: _enteredUserName,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          decoration: InputDecoration(
                            label: Text('Username',
                                style: TextStyle(color: Colors.blue[200])),
                            prefixIcon:
                                Icon(Icons.person_2, color: Colors.blue[200]),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Password field
                        TextField(
                          controller: _enteredPassword,
                          obscureText: true,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          decoration: InputDecoration(
                            label: Text('Password',
                                style: TextStyle(color: Colors.blue[200])),
                            prefixIcon:
                                Icon(Icons.lock, color: Colors.blue[200]),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Register button
                        SizedBox(
                          width: 200,
                          child: TextButton(
                            onPressed: _register,
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[900],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Login link
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/');
                            print("Navigate to Login Screen");
                          },
                          child: const Text(
                            "Already have an account? Login here",
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
