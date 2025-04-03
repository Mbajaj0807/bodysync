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

        // Return the data as a map
        return documentSnapshot.data() as Map<String, dynamic>;
      } catch (e) {
        throw Exception("Error fetching user data: $e");
      }
    } else {
      throw Exception("User not logged in.");
    }
  }
}
