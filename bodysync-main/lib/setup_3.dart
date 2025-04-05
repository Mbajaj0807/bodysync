import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bodysync/homepage.dart'; // Import MyHomePage

enum Goal { loseweight, gainweight, musclemassgain, tonedbody }

class SetUp3 extends StatefulWidget {
  const SetUp3({super.key});

  @override
  State<SetUp3> createState() => _SetUp3State();
}

class _SetUp3State extends State<SetUp3> {
  Goal? _selectedGoal;

  // Function to save goal and experience level to Firestore
  Future<void> saveUserGoal(String experienceLevel) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("User not logged in")));
        return;
      }

      if (_selectedGoal == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Please select a goal")));
        return;
      }

      String goal =
          _selectedGoal.toString().split('.').last; // Convert enum to string

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'goal': goal,
        'experienceLevel': experienceLevel,
      }, SetOptions(merge: true));

      // Navigate to MyHomePage
      Navigator.pushReplacementNamed(context, '/myhomepage');
      // Navigate to MyHomePage
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving goal: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 100, left: 5),
                child: Text(
                  "Let Us Help You",
                  style: TextStyle(
                    color: Color.fromRGBO(226, 241, 99, 1),
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Goal Selection Container
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(137, 108, 254, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 25, left: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "What is your goal?",
                            style: TextStyle(
                              color: Color.fromRGBO(249, 249, 249, 1),
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      RadioListTile(
                        title: const Text(
                          "Lose Weight",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        value: Goal.loseweight,
                        groupValue: _selectedGoal,
                        onChanged: (Goal? value) {
                          setState(() {
                            _selectedGoal = value;
                          });
                        },
                        activeColor: const Color.fromRGBO(226, 241, 99, 1),
                      ),
                      RadioListTile(
                        title: const Text(
                          "Gain Weight",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        value: Goal.gainweight,
                        groupValue: _selectedGoal,
                        onChanged: (Goal? value) {
                          setState(() {
                            _selectedGoal = value;
                          });
                        },
                        activeColor: const Color.fromRGBO(226, 241, 99, 1),
                      ),
                      RadioListTile(
                        title: const Text(
                          "Muscle Mass Gain",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        value: Goal.musclemassgain,
                        groupValue: _selectedGoal,
                        onChanged: (Goal? value) {
                          setState(() {
                            _selectedGoal = value;
                          });
                        },
                        activeColor: const Color.fromRGBO(226, 241, 99, 1),
                      ),
                      RadioListTile(
                        title: const Text(
                          "Toned Body",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        value: Goal.tonedbody,
                        groupValue: _selectedGoal,
                        onChanged: (Goal? value) {
                          setState(() {
                            _selectedGoal = value;
                          });
                        },
                        activeColor: const Color.fromRGBO(226, 241, 99, 1),
                      ),
                    ],
                  ),
                ),
              ),

              // Informational Text
              const Padding(
                padding: EdgeInsets.only(top: 30, left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Whether you're a beginner or a trained professional, we're here to help you with your fitness journey.",
                    style: TextStyle(
                      color: Color.fromRGBO(249, 249, 249, 1),
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),

              // Experience Level Buttons
              Padding(
                padding: const EdgeInsets.only(top: 65),
                child: SizedBox(
                  height: 60,
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () => saveUserGoal("Beginner"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
                      side: const BorderSide(color: Colors.white, width: 1.5),
                    ),
                    child: const Text(
                      "Beginner",
                      style: TextStyle(
                        fontSize: 25,
                        color: Color.fromRGBO(137, 108, 254, 1),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: SizedBox(
                  height: 60,
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () => saveUserGoal("Intermediate"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
                      side: const BorderSide(color: Colors.white, width: 1.5),
                    ),
                    child: const Text(
                      "Intermediate",
                      style: TextStyle(
                        fontSize: 25,
                        color: Color.fromRGBO(137, 108, 254, 1),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: SizedBox(
                  height: 60,
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () => saveUserGoal("Advanced"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(249, 249, 249, 1),
                      side: const BorderSide(color: Colors.white, width: 1.5),
                    ),
                    child: const Text(
                      "Advanced",
                      style: TextStyle(
                        fontSize: 25,
                        color: Color.fromRGBO(137, 108, 254, 1),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
