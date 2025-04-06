import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bodysync/Services/authentication.dart';
import 'homepage.dart';
import 'page0.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  void loginUser() async {
    setState(() {
      isLoading = true;
    });

    String res = await AuthServices().loginUser(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (res == 'success') {
      print('Login successful');
      setState(() {
        isLoading = false;
      });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MyHomePage(title: 'Home Page'),
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      print('Login failed: $res');
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(35, 35, 35, 1), // Background color
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/login_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color.fromRGBO(226, 241, 99, 1),
              ),
              onPressed: () {
                Navigator.pop(context); // First close the dialog
                Future.delayed(Duration.zero, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Page0()),
                  );
                });
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * .2,
            left: 20,
            right: 20,
            child: Text(
              'Welcome \n Elevate your Fitness - One Login At A Time',
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
              height: 275,
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
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Username or Email',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: ElevatedButton(
                        onPressed: isLoading ? null : loginUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(
                            137,
                            108,
                            254,
                            1,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                        ),
                        child:
                            isLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : Text(
                                  'Log In',
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    color: const Color.fromRGBO(
                                      226,
                                      241,
                                      99,
                                      1,
                                    ),
                                  ),
                                ),
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
