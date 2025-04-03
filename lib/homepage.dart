import 'package:bodysync/setup_1.dart';
import 'package:flutter/material.dart';
import 'package:bodysync/community.dart';
import 'package:bodysync/nutrition.dart';
import 'package:bodysync/progress_tracking.dart';
import 'widgets/exercise_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Services/authentication.dart';
import 'data_fetch.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  static const String routeName = '/myhomepage';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final AuthServices authServices = AuthServices();

// ✅ Function to Get User's Name from Firestore
Future<String?> getUserName() async {
  var user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    var data =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
    return data.data()?['name'] ?? 'Guest'; // Safe check for missing field
  }
  return 'Guest';
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(35, 35, 35, 1),

      // ✅ Drawer with FutureBuilder to fetch user data
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(35, 35, 35, 1)),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(137, 108, 254, 1),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                    ),
                    FutureBuilder<Map<String, dynamic>>(
                      future: DataFetch().fetchUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Error: ${snapshot.error}'),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data == null) {
                          return Center(child: Text('No Data Available'));
                        }

                        //  Extract user data safely
                        Map<String, dynamic> userData = snapshot.data!;
                        String displayName = userData['name'] ?? 'Guest';

                        return Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            'Hi, $displayName',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text('Button 1', style: TextStyle(color: Colors.white)),
              ),
              ListTile(
                title: Text('Button 2', style: TextStyle(color: Colors.white)),
              ),
              ListTile(
                title: Text('Button 3', style: TextStyle(color: Colors.white)),
              ),
              ListTile(
                title: Text('Button 4', style: TextStyle(color: Colors.white)),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: ListTile(
                  title: Text('LogOut', style: TextStyle(color: Colors.white)),
                  onTap: () async {
                    await authServices.signOut();
                    if (mounted) {
                      Navigator.pushReplacementNamed(context, "/page0");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // ✅ AppBar with FutureBuilder for User Greeting
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromRGBO(137, 108, 254, 1)),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
        flexibleSpace: Container(
          key: const ValueKey('AppBar'),
          height: 120,
          padding: const EdgeInsets.only(left: 14, top: 30),
          child: FutureBuilder<String?>(
            future: getUserName(),
            builder: (context, snapshot) {
              String displayName =
                  snapshot.hasData && snapshot.data != null
                      ? snapshot.data!
                      : 'Guest';
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40, top: 20),
                    child: Text(
                      'Hi $displayName',
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

      // ✅ Main Body
      body: Stack(
        children: [
          Positioned.fill(
            top: 0,
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
                            onTap: () => print('Pressed'),
                          ),
                          ExerciseCard(
                            exerciseName: 'Squats',
                            time: '15 min',
                            calories: '80',
                            onTap: () => print('Pressed'),
                          ),
                          ExerciseCard(
                            exerciseName: 'Plank',
                            time: '5 min',
                            calories: '30',
                            onTap: () => print('Pressed'),
                          ),
                        ],
                      ),
                    ),

                    Container(height: 500),
                  ],
                ),
              ),
            ),
          ),

          // ✅ Bottom Navigation Bar
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
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SetUp(),
                          ),
                        ),
                    child: Image.asset(
                      'assets/icon1.png',
                      height: 80,
                      width: 80,
                    ),
                  ),
                  InkWell(
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Community(),
                          ),
                        ),
                    child: Image.asset(
                      'assets/icon2.png',
                      height: 80,
                      width: 80,
                    ),
                  ),
                  InkWell(
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Nutrition(),
                          ),
                        ),
                    child: Image.asset(
                      'assets/icon3.png',
                      height: 80,
                      width: 80,
                    ),
                  ),
                  InkWell(
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProgressTracking(),
                          ),
                        ),
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
