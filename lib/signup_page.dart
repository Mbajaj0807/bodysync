import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});
  static const String routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(35, 35, 35, 1),
        iconTheme: IconThemeData(
          color: Color.fromRGBO(226, 241, 99, 1),
          size: 30,
        ),
      ),
      backgroundColor: Color.fromRGBO(35, 35, 35, 1), // Background color
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * .1,
            left: 20,
            right: 20,
            child: Text(
              'Welcome \n Let\'s Start',
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Center(
            child: Container(
              height: 400,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, .5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Username or Email',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Password ',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/myhomepage');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(137, 108, 254, 1),
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                        ),
                        child: Text(
                          'Sign up',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Color.fromRGBO(226, 241, 99, 1),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: InkWell(
                        onTap: () {},
                        mouseCursor: SystemMouseCursors.click,
                        child: Text('Forgot Password'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
