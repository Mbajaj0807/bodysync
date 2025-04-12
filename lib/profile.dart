

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      setState(() {
        print("Current UID: $uid");
        userData = doc.data();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(137, 108, 254, 1),
        title: Text(
          'Your Profile',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: const Color.fromRGBO(226, 241, 99, 1),
          ),
        ),
        centerTitle: true,
      ),
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(Icons.account_circle, size: 120, color: Color.fromRGBO(226, 241, 99, 1)),
          const SizedBox(height: 20),
          buildInfo("Name", userData?['name']),
          buildInfo("Email", userData?['email']),
          buildInfo("User Tag", userData?['userTag']),
          buildInfo("Age", userData?['age'].toString()),
          buildInfo("Gender", userData?['gender']),
          buildInfo("Goal", userData?['goal']),
          buildInfo("Experience", userData?['experienceLevel']),
          buildInfo("Height", "${userData?['height']} cm"),
          buildInfo("Weight", "${userData?['weight']} kg"),
          buildInfo("Maintenance Calories", "${userData?['maintenanceCalories']}"),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(226, 241, 99, 1),
            ),
            child: Text(
              'Back to Home',
              style: GoogleFonts.poppins(
                color: const Color.fromRGBO(35, 35, 35, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfo(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        "$label: $value",
        style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
      ),
    );
  }
}

