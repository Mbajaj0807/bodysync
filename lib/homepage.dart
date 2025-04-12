import 'package:bodysync/Dashboard_card.dart';
import 'package:bodysync/nutrition.dart';
import 'package:bodysync/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:bodysync/community.dart';
import 'package:bodysync/progress_tracking.dart';
import 'widgets/exercise_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Services/authentication.dart';
import 'Services/data_fetch.dart';
import 'chat_ui.dart';
import 'nutrition.dart';
import 'clickable_parts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  static const String routeName = '/myhomepage';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final AuthServices authServices = AuthServices();
Widget _verticalDivider() {
  return const VerticalDivider(
    color: Color.fromRGBO(226, 241, 99, 1),
    thickness: 1.8,
    width: 10,
    indent: 30,
    endIndent: 30,
  );
}

Widget _buildNavItem(String assetPath, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Image.asset(assetPath, height: 35, width: 35),
  );
}

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
              SizedBox(
                height: 190,
                child: DrawerHeader(
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
                          String userTag = userData['userTag'] ?? 'Unknown0000';
                          return Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Column(
                              children: [
                                Text(
                                  'Hi, $displayName',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'User id: $userTag',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
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
                      Navigator.pushReplacementNamed(context, "/login");
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
        leading: Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ), // Adjust this value as needed
          child: Builder(
            builder:
                (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
          ),
        ),
        flexibleSpace: Container(
          key: const ValueKey('AppBar'),
          height: 120,
          padding: const EdgeInsets.only(left: 10, top: 30),
          child: FutureBuilder<String?>(
            future: getUserName(),
            builder: (context, snapshot) {
              String displayName =
                  snapshot.hasData && snapshot.data != null
                      ? snapshot.data!
                      : 'Guest';
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40, top: 20),
                    child: Text(
                      'Hi $displayName',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(137, 108, 254, 1),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 22, right: 15),
                        child: SizedBox(
                          height: 25,
                          child: _buildNavItem('assets/chatbot.png', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AIFitnessChatPage(),
                              ),
                            );
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 22, right: 15),
                        child: SizedBox(
                          height: 25,
                          child: _buildNavItem('assets/profile-user.png', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
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
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    const Text(
                      textAlign: TextAlign.center,
                      'Click on the body part you want to train',
                      style: TextStyle(
                        color: Color.fromRGBO(226, 241, 99, 1),
                        fontSize: 20,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: ClickableBody(
                        onPartTap: (part) {
                          print('Tapped on $part');
                          // TODO: Navigate or update based on selected body part
                        },
                      ),
                    ),

                    DashboardCard(),

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

          // Bottom Navigation Bar
          Positioned(
            left: 5,
            bottom: 20,
            right: 5,
            child: Container(
              key: const ValueKey('navigation'),
              height: 100,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(137, 108, 254, 1),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem('assets/icon1.png', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AIFitnessChatPage(),
                      ),
                    );
                  }),
                  _verticalDivider(),
                  _buildNavItem('assets/icon2.png', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Community(),
                      ),
                    );
                  }),
                  _verticalDivider(),
                  _buildNavItem('assets/icon3.png', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Nutrition()),
                    );
                  }),
                  _verticalDivider(),
                  _buildNavItem('assets/icon4.png', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProgressTracking(),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
