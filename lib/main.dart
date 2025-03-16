import 'package:flutter/material.dart';
import 'widgets/exercise_card.dart';
import 'workout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              key: const ValueKey('AppBar'),
              height: 120,
              color: Color.fromRGBO(35, 35, 35, 1),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14, top: 30),
                    child: Text(
                      'Hi Fitfreak',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(137, 108, 254, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            top: 120,
            bottom: 100,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Column(
                  children: [
                    Text(
                      'Click on the body part you want to train',
                      style: TextStyle(
                        color: Color.fromRGBO(226, 241, 99, 1),
                        fontSize: 20,
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: 660,
                        width: 300,
                        child: Image.asset('assets/Dummy_model.png'),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Recommendations',
                        style: TextStyle(
                          color: Color.fromRGBO(226, 241, 99, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ExerciseCard(
                            exerciseName: 'Push Ups',
                            time: '10 min',
                            calories: '50',
                            onTap: () {
                              print('Pressed');
                            },
                          ),
                          ExerciseCard(
                            exerciseName: 'Push Ups',
                            time: '10 min',
                            calories: '50',
                            onTap: () {
                              print('Pressed');
                            },
                          ),
                          ExerciseCard(
                            exerciseName: 'Push Ups',
                            time: '10 min',
                            calories: '50',
                            onTap: () {
                              print('Pressed');
                            },
                          ),
                          ExerciseCard(
                            exerciseName: 'Push Ups',
                            time: '10 min',
                            calories: '50',
                            onTap: () {
                              print('Pressed');
                            },
                          ),
                          ExerciseCard(
                            exerciseName: 'Push Ups',
                            time: '10 min',
                            calories: '50',
                            onTap: () {
                              print('Pressed');
                            },
                          ),
                          ExerciseCard(
                            exerciseName: 'Push Ups',
                            time: '10 min',
                            calories: '50',
                            onTap: () {
                              print('Pressed');
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            left: 5,
            bottom: 20,
            right: 5,
            child: Container(
              key: const ValueKey('navigation'),
              height: 120, // Increased container height
              decoration: BoxDecoration(
                color: const Color.fromRGBO(137, 108, 254, 1),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Distribute evenly
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Workout(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/icon1.png',
                      height: 80,
                      width: 80,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Workout(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/icon2.png',
                      height: 80,
                      width: 80,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Workout(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/icon3.png',
                      height: 80,
                      width: 80,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Workout(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/icon4.png',
                      height: 80,
                      width: 80,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
