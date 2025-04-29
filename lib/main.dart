import 'package:bodysync/page0.dart';
import 'package:bodysync/widgets/tnc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'launch_page.dart';
import 'homepage.dart';
import 'login_page.dart';
import 'signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BodySync',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LaunchPage(), // initial route
        
        '/login': (context) => const LoginPage(),
        
        '/signup': (context) => SignupPage(),
        '/unauthenticated': (context) => const Page0(), // not logged in
        '/authenticated':
            (context) => const MyHomePage(title: 'Home Page'), // logged in
      },
    );
  }
}
