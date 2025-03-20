import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
        UserCredential cred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(cred.user!.uid)
            .set({'name': name, 'email': email, 'createdAt': DateTime.now()});

        res = 'success';
      } else {
        res = 'Please fill in all fields';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        print('Attempting login for email: $email');

        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        print('Login successful for email: $email');
        res = 'success';
      } else {
        res = "Please enter all fields";
        print('Failed login: Fields are empty');
      }
    } on FirebaseAuthException catch (e) {
      print('Login error: ${e.code} - ${e.message}');
      if (e.code == 'user-not-found') {
        res = 'No user found for that email';
      } else if (e.code == 'wrong-password') {
        res = 'Wrong password provided';
      } else if (e.code == 'invalid-email') {
        res = 'Invalid email format';
      } else {
        res = e.message ?? 'An unknown error occurred';
      }
    } catch (e) {
      print('Unexpected error: $e');
      res = e.toString();
    }
    return res;
  }
}
