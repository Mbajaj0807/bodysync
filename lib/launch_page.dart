import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({super.key});

  Future<bool> checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate a small delay
    final user = FirebaseAuth.instance.currentUser;
    return user != null; // true if user is logged in
  }

  @override
  Widget build(BuildContext context) {
    // Delay for splash + check login
    Future.delayed(const Duration(seconds: 5), () async {
      bool isLoggedIn = await checkLoginStatus();
      if (context.mounted) {
        Navigator.pushReplacementNamed(
          context,
          isLoggedIn ? '/authenticated' : '/unauthenticated',
        );
      }
    });

    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 35, 35, 1),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 25,
                  color: Color.fromRGBO(249, 249, 249, 1),
                ),
                children: [
                  TextSpan(
                    text: 'Dive Into The World Of',
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      color: const Color.fromRGBO(137, 108, 254, 1),
                    ),
                  ),
                  TextSpan(
                    text: ' Fitness',
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(226, 241, 99, 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
