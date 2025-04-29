import 'package:flutter/material.dart';

class TermsAndConditions {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // Tap outside to close if you want
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color.fromRGBO(35, 35, 35, .9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.8,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'ETHICAL GUIDELINES\nAt BodySync, we are committed to maintaining the highest ethical standards in delivering fitness and nutrition guidance to our users.\nOur mission is to empower individuals to achieve their health and fitness goals by providing accessible, data-driven workout plans and nutritional advice sourced from reputable online information.\nSince the app does not involve fitness or nutrition professionals, we aim to be transparent about our sources and encourage users to consult healthcare providers for personalized advice when needed.\n\n1. User Well-Being and Safety\nUser health and safety are our top priorities.\nWe strive to provide guidance that is safe, balanced, and effective by sourcing information from trustworthy and scientifically supported online sources.\nWhile we aim to offer accurate workout and nutrition suggestions, we acknowledge that not all fitness routines or diets are suitable for everyone.\n- BodySync is designed to support general fitness and wellness goals, not to diagnose or treat medical conditions.\n- We encourage users to listen to their bodies and avoid any exercises or diet plans that cause discomfort or adverse reactions.\n- We recommend consulting a healthcare professional or certified fitness trainer before starting any new workout or nutrition plan, especially for users with pre-existing medical conditions or unique dietary needs.\n\n2. Transparency and Honesty\nTransparency is fundamental to user trust.\nWe are upfront about the fact that the workout and nutrition recommendations provided in BodySync are sourced from publicly available online content rather than certified professionals.\n- All workout routines, meal plans, and health tips are clearly labeled as information sourced from the internet.\n- We do not make misleading claims about fitness results or health benefits.\n- Any data collected from users to personalize the experience (e.g., weight, height, fitness goals) is handled securely and used solely to enhance the user experience.\n\n3. Inclusivity and Non-Discrimination\nBodySync is committed to creating a welcoming and inclusive environment for all users, regardless of race, ethnicity, gender identity, age, sexual orientation, or fitness level.\n- We strive to provide workout routines and nutrition plans that are adaptable to diverse body types, fitness levels, and cultural preferences.\n- We do not tolerate harassment, discrimination, or offensive language within the app’s community section.\n- Any content that promotes harmful behavior, negative body image, or unrealistic fitness expectations will be removed, and the responsible user may face account suspension or termination.\n\n4. Data Protection and Privacy\nWe take data protection seriously and are committed to safeguarding user information.\nAll user data is encrypted and stored securely using industry-standard protocols.\nWe do not share or sell personal data to third parties without user consent.\n- Users have full control over their personal information and can modify or delete their data at any time.\n- We provide clear explanations on how user data is collected, used, and stored through our Privacy Policy.\n- User data is used strictly to personalize the app experience and improve app functionality.\n\n______________________________________\nPRIVACY POLICY\nEffective Date: [Insert Date]\nThis Privacy Policy outlines how BodySync collects, uses, and protects user information when using the app.\nBy downloading and using BodySync, you agree to the terms outlined in this policy.\n\n1. Information We Collect\nWe collect the following types of data to provide personalized workout and nutrition recommendations and improve app performance:\n\na) Personal Information\n- Name\n- Email address\n- Date of birth\n- Gender\n- Weight and height\n- Fitness goals and physical activity level\n\nb) Health and Activity Data\n- Workout logs (e.g., type of exercise, duration, calories burned)\n- Steps walked (if integrated with health tracking devices)\n- Calories burned and daily activity',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                    },
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
