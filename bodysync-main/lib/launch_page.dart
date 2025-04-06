import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to the home screen after 2 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/home');
    });

    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 35, 35, 1), // Background color
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromRGBO(249, 249, 249, 1),
                ),
                children: [
                  TextSpan(
                    text: 'Dive Into The World Of',
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      color: Color.fromRGBO(137, 108, 254, 1),
                    ),
                  ),
                  TextSpan(
                    text: ' Fitness',
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(226, 241, 99, 1),
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
