import 'package:cloud_firestore/cloud_firestore.dart';

class StudentService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Fetch all quiz sections for students
  Future<List<Map<String, dynamic>>> fetchSections() async {
    try {
      // Get the 'sections' collection
      QuerySnapshot snapshot = await _db.collection('sections').get();

      // Map the documents to a list of maps (id, title, and imageAsset)
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'title': doc['title'], // Assuming you have a 'title' field
        };
      }).toList();
    } catch (e) {
      print('Error fetching sections: $e');
      return [];
    }
  }
}
