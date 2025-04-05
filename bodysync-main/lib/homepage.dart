import 'package:bodysync/homepage2.dart';
import 'package:bodysync/recipe_services.dart';
import 'package:bodysync/setup_1.dart';
import 'package:flutter/material.dart';
import 'package:bodysync/community.dart';
import 'package:bodysync/nutrition.dart';
import 'package:bodysync/progress_tracking.dart';
// import 'package:bodysync/workout.dart';
import 'widgets/exercise_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Services/authentication.dart';
import 'package:bodysync/homepage.dart';  // Import HomePage


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  static const String routeName = '/myhomepage';
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final AuthServices authServices = AuthServices();
Future<String?> getUserName() async {
  var user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    var data =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
    return data['name']; // Ensure the 'name' field exists in Firestore
  }
  return null;
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              key: const ValueKey('AppBar'),
              height: 120,
              color: const Color.fromRGBO(35, 35, 35, 1),
              child: FutureBuilder<String?>(
                future: getUserName(),
                builder: (context, snapshot) {
                  String displayname = snapshot.data ?? 'Guest';

                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 14, top: 30),
                        child: Text(
                          'Hi $displayname',
                          style: const TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(137, 108, 254, 1),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Positioned.fill(
            top: 120,
            bottom: 100,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Text(
                      'Click on the body part you want to train',
                      style: TextStyle(
                        color: Color.fromRGBO(226, 241, 99, 1),
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 625,
                      width: 300,
                      child: Image.asset('assets/Dummy_model.png'),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Recommendations',
                        style: TextStyle(
                          color: Color.fromRGBO(226, 241, 99, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ExerciseCard(
                            exerciseName: 'Push Up',
                            time: '10 min',
                            calories: '50',
                            onTap: () {
                              print('Pressed');
                            },
                          ),
                          ExerciseCard(
                            exerciseName: 'Push Ups',
                            time: '10 min',
                            calories: '50',
                            onTap: () {
                              print('Pressed');
                            },
                          ),
                          ExerciseCard(
                            exerciseName: 'Push Ups',
                            time: '10 min',
                            calories: '50',
                            onTap: () {
                              print('Pressed');
                            },
                          ),
                          ExerciseCard(
                            exerciseName: 'Push Ups',
                            time: '10 min',
                            calories: '50',
                            onTap: () {
                              print('Pressed');
                            },
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await authServices.signOut();
                        if (mounted) {
                          Navigator.pushReplacementNamed(context, "/login");
                        }
                      },
                      child: Text('Logout'),
                    ),
                    Container(height: 500),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 5,
            bottom: 20,
            right: 5,
            child: Container(
              key: const ValueKey('navigation'),
              height: 120,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(137, 108, 254, 1),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SetUp()),
                      );
                    },
                    child: Image.asset(
                      'assets/icon1.png',
                      height: 80,
                      width: 80,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Community(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/icon2.png',
                      height: 80,
                      width: 80,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),  // Navigate to HomePage
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/icon3.png',
                      height: 80,
                      width: 80,
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProgressTracking(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/icon4.png',
                      height: 80,
                      width: 80,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
