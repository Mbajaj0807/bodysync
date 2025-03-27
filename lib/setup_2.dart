import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'setup_3.dart';

enum Gender { male, female }

class SetUp2 extends StatefulWidget {
  const SetUp2({super.key});
  @override
  State<SetUp2> createState() => _SetUp2State();
}

class _SetUp2State extends State<SetUp2> {
  Gender? _selectedGender;
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  // Function to save data to Firestore
  Future<void> saveUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser; // Get logged-in user
      if (user == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("User not logged in")));
        return;
      }

      String gender = _selectedGender == Gender.male ? "Male" : "Female";
      int age = int.tryParse(ageController.text) ?? 0;
      double weight = double.tryParse(weightController.text) ?? 0.0;
      double height = double.tryParse(heightController.text) ?? 0.0;

      if (age == 0 ||
          weight == 0.0 ||
          height == 0.0 ||
          _selectedGender == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill all fields correctly")),
        );
        return;
      }

      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {'gender': gender, 'age': age, 'weight': weight, 'height': height},
      );

      // Navigate to the next page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SetUp3()),
      );
    } catch (e) {
      print("Error saving data: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 100, left: 5),
            child: Text(
              "Fill Your Details Below",
              style: TextStyle(
                color: Color.fromRGBO(226, 241, 99, 1),
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Gender selection
          const Padding(
            padding: EdgeInsets.only(top: 50, left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "What is your gender?",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          RadioListTile(
            title: const Text(
              "Male",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            value: Gender.male,
            groupValue: _selectedGender,
            onChanged: (Gender? value) {
              setState(() {
                _selectedGender = value;
              });
            },
            activeColor: const Color.fromRGBO(137, 108, 254, 1),
          ),
          RadioListTile(
            title: const Text(
              "Female",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            value: Gender.female,
            groupValue: _selectedGender,
            onChanged: (Gender? value) {
              setState(() {
                _selectedGender = value;
              });
            },
            activeColor: const Color.fromRGBO(137, 108, 254, 1),
          ),
          // Age input
          buildTextField("How old are you?", "Enter age", ageController),
          // Weight input
          buildTextField(
            "What is your weight?",
            "Enter weight in kg",
            weightController,
          ),
          // Height input
          buildTextField(
            "What is your height?",
            "Enter height in cm",
            heightController,
          ),
          // Next Button
          Padding(
            padding: const EdgeInsets.only(top: 65),
            child: SizedBox(
              height: 50,
              width: 180,
              child: ElevatedButton(
                onPressed: saveUserData, // Call function to save data
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
                  side: const BorderSide(color: Colors.white, width: 1.5),
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build input fields
  Widget buildTextField(
    String label,
    String hint,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 25),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 450,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(137, 108, 254, 1),
                  ),
                ),
                border: const OutlineInputBorder(),
                labelText: hint,
                labelStyle: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
