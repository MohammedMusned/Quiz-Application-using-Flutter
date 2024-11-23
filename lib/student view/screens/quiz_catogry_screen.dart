import 'package:flutter/material.dart';
import 'package:quiz_app/servcies/student_service.dart';

import 'package:quiz_app/student%20view/items/catogry_item.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final StudentService _studentService = StudentService();
  List<Map<String, dynamic>> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  // Load categories from Firestore using StudentService
  _loadCategories() async {
    List<Map<String, dynamic>> categories =
        await _studentService.fetchSections();
    setState(() {
      _categories = categories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 11, 38, 60),
      appBar: AppBar(
        title: Text(
          'Quiz Categories',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 27, 92, 145),
      ),
      body: _categories.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loading indicator while fetching data
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _categories.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: CategoryItem(
                    id: _categories[index]['id']!,
                    title: _categories[index]['title']!,
                  ),
                );
              },
            ),
    );
  }
}
