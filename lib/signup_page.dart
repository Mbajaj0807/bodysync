import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Services/authentication.dart';
import 'package:bodysync/setup_1.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static const String routeName = '/signup';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false;

  void signUpUser() async {
    print("🔁 Signup initiated");

    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      print("⚠️ Fields are empty");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('All fields are required')));
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      print("❌ Passwords do not match");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    setState(() {
      isLoading = true;
    });

    print("📩 Sending signup request...");
    String res = await AuthServices().signUpUser(
      email: emailController.text.trim(),
      name: nameController.text.trim(),
      password: passwordController.text,
    );

    print("📬 Response from AuthServices: $res");

    if (res == "success") {
      print("✅ Signup successful. Navigating to SetUp page.");
      setState(() {
        isLoading = false;
      });
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => const SetUp()));
    } else {
      print("❌ Signup failed. Error: $res");
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
        iconTheme: const IconThemeData(
          color: Color.fromRGBO(226, 241, 99, 1),
          size: 30,
        ),
      ),
      backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
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
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    ),
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
                    TextField(
                      controller: confirmPasswordController,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: ElevatedButton(
                        onPressed: isLoading ? null : signUpUser,
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
                                  'Sign up',
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
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: InkWell(
                        onTap: () {},
                        mouseCursor: SystemMouseCursors.click,
                        child: const Text('Forgot Password'),
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
