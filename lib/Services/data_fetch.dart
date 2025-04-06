// lib/data_fetch.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataFetch {
  // Fetch user data using the current logged-in user's ID
  Future<Map<String, dynamic>> fetchUserData() async {
    // Get the current user's ID
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      try {
        // Fetch user data based on the current user's ID
        DocumentSnapshot documentSnapshot =
            await FirebaseFirestore.instance
                .collection('users') // Replace with your collection name
                .doc(currentUser.uid) // Use the logged-in user's ID
                .get();

        // Check if the document exists and contains data
        if (documentSnapshot.exists) {
          var data = documentSnapshot.data(); // Get data as dynamic type

          // Check if data is not null and is a Map<String, dynamic>
          if (data != null && data is Map<String, dynamic>) {
            return data;
          } else {
            throw Exception("User data is not in the expected format.");
          }
        } else {
          throw Exception("No user data found for this user.");
        }
      } catch (e) {
        throw Exception("Error fetching user data: $e");
      }
    } else {
      throw Exception("User not logged in.");
    }
  }
}
