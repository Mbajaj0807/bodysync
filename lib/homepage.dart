import 'package:bodysync/Dashboard_card.dart';
import 'package:bodysync/Workout/bicep.dart';
import 'package:bodysync/joingym.dart';
import 'package:bodysync/nutrition.dart';
import 'package:bodysync/premium.dart';
import 'package:bodysync/profile_page.dart';
import 'package:bodysync/widgets/articlecard.dart';
import 'package:flutter/material.dart';
import 'package:bodysync/community.dart';
import 'package:bodysync/progress_tracking.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Services/authentication.dart';
import 'Services/data_fetch.dart';
import 'chat_ui.dart';
import 'clickable_parts.dart';
import 'daily_quiz_card.dart';
import 'stat_card.dart';

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

Widget _horizontalDivider() {
  return const Divider(
    color: Color.fromRGBO(137, 108, 254, 0.5),
    thickness: 1,
    indent: 10,
    endIndent: 10,
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
                height: 210,
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
                            padding: const EdgeInsets.only(top: 5, bottom: 0),
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
                                Text(
                                  'Not a member of any gym',
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
                title: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GoPremium()),
                    );
                  },
                  child: Text(
                    'Go Premium',
                    style: TextStyle(color: Color.fromRGBO(137, 108, 254, 1)),
                  ),
                ),
              ),
              _horizontalDivider(),
              ListTile(
                title: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JoinGym()),
                    );
                  },
                  child: Text(
                    'Join Your Gym',
                    style: TextStyle(color: Color.fromRGBO(137, 108, 254, 1)),
                  ),
                ),
              ),
              _horizontalDivider(),
              ListTile(
                title: Text(
                  'Delete Account',
                  style: TextStyle(color: Color.fromRGBO(137, 108, 254, 1)),
                ),
              ),
              _horizontalDivider(),
              ListTile(
                title: Text(
                  'LogOut',
                  style: TextStyle(color: Color.fromRGBO(137, 108, 254, 1)),
                ),
                onTap: () async {
                  await authServices.signOut();
                  if (mounted) {
                    Navigator.pushReplacementNamed(context, "/login");
                  }
                },
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
          Positioned(
            top: 0,
            child: Container(
              //Add Marquee Here
              height: 20,
              width: MediaQuery.of(context).size.width,
              color: const Color.fromARGB(255, 3, 3, 3),
            ),
          ),

          Positioned.fill(
            top: 20,
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
                    StatCard(),
                    SizedBox(height: 100),
                    DailyQuizCard(),
                    SizedBox(height: 20),
                    DashboardCard(),
                    const SizedBox(height: 20),
                    Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      color: Color.fromRGBO(137, 108, 254, 1),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ArticleCard(
                              imagePath: 'assets/shoulder.jpg',
                              title: '15 Ways to Burn 150 Calories',
                              body: 'Shoulder Workout',
                            ),
                            ArticleCard(
                              imagePath: 'assets/shoulder.jpg',
                              title: 'A 30-minute, Do-Anywhere HIIT Workout ',
                              body: 'A 30-minute, Do-Anywhere HIIT Workout ',
                            ),
                            ArticleCard(
                              imagePath: 'assets/shoulder.jpg',
                              title: 'How to Use Resistance Bands',
                              body: 'Shoulder Workout',
                            ),
                            ArticleCard(
                              imagePath: 'assets/shoulder.jpg',
                              title: 'Are There Negative Effects of Walking',
                              body: 'Shoulder Workout',
                            ),
                          ],
                        ),
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
                  _buildNavItem('assets/icon1.png', () {}),
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
