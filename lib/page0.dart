import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Page0 extends StatelessWidget {
  const Page0({super.key});

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 30),
            SizedBox(
              width: 200,
              height: 70,

              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(137, 108, 254, 1),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text(
                  'Log In',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Color.fromRGBO(226, 241, 99, 1),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 200,
              height: 70,

              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(226, 241, 99, 1),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Color.fromRGBO(137, 108, 254, 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
