import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets/tnc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<Map<String, dynamic>?> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("My Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(137, 108, 254, 1),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.purple),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text(
                "No user data found",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final userData = snapshot.data!;
          final String name = userData['name'] ?? "Name not set";
          final String email = userData['email'] ?? "Email not set";
          final String birthday = userData['birthday'] ?? "Birthday not set";
          final int age = (userData['age'] ?? 0).toInt();
          final double weight = (userData['weight'] ?? 0).toDouble();
          final double height = (userData['height'] ?? 0).toDouble();

          return Column(
            children: [
              // Profile Header
              Container(
                color: Color.fromRGBO(137, 108, 254, 1),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/profile-user.png'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(email, style: const TextStyle(color: Colors.white)),
                    Text(
                      "Birthday: $birthday",
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "${weight.toStringAsFixed(1)} Kg",
                              style: const TextStyle(color: Colors.white),
                            ),
                            const Text(
                              "Weight",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "$age",
                              style: const TextStyle(color: Colors.white),
                            ),
                            const Text(
                              "Years Old",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "${height.toStringAsFixed(2)} cm",
                              style: const TextStyle(color: Colors.white),
                            ),
                            const Text(
                              "Height",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Menu
              Expanded(
                child: Container(
                  color: Color.fromRGBO(35, 35, 35, 1),
                  child: ListView(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.star,
                          color: Color.fromRGBO(137, 108, 254, 1),
                        ),
                        title: Text(
                          "Favorite",
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FavoritePage(),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.policy,
                          color: Color.fromRGBO(137, 108, 254, 1),
                        ),
                        title: Text(
                          "Privacy Policy",
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onTap: () {
                          // Directly show Terms and Conditions when "Privacy Policy" is tapped
                          TermsAndConditions.show(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: Color.fromRGBO(137, 108, 254, 1),
                        ),
                        title: Text(
                          "Settings",
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsPage(),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.help,
                          color: Color.fromRGBO(137, 108, 254, 1),
                        ),
                        title: Text(
                          "Help",
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HelpPage(),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Color.fromRGBO(137, 108, 254, 1),
                        ),
                        title: Text(
                          "Logout",
                          style: const TextStyle(color: Colors.white),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Notes'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
        currentIndex: 0,
        selectedItemColor: Color.fromRGBO(137, 108, 254, 1),
        onTap: (index) {
          // Add navigation logic for bottom nav here if needed
        },
      ),
    );
  }
}

// Example placeholder pages for the navigation
class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Favorites Page")));
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Settings Page")));
  }
}

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Help Page")));
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Login Page")));
  }
}
