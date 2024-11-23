// lib/models/user.dart
class User {
  final String name;
  final String username;
  final String password;

  User({
    required this.name,
    required this.username,
    required this.password,
  });

  // Convert User object to a Map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'password': password,
    };
  }

  // Create a User object from a Map (from Firestore)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      username: map['username'],
      password: map['password'],
    );
  }
}
