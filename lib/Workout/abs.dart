import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bodysync/widgets/exercise_card.dart';

class AbsWorkout extends StatelessWidget {
  const AbsWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
      appBar: AppBar(
        title: const Text('Abs'),
        backgroundColor: const Color.fromRGBO(137, 108, 254, 1),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance
                  .collection('workouts')
                  .doc('abs')
                  .collection('items')
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  'No exercises found',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final exercises = snapshot.data!.docs;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 12.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children:
                      exercises.map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ExerciseCard(
                            exerciseName: data['name'] ?? 'Unknown',
                            time: data['time'] ?? '0min',
                            calories: data['calories']?.toString() ?? '0',
                            imagePath: data['imagepath'] ?? 'assets/back.jpg',
                            onTap: () {
                              // Handle tap if needed
                            },
                          ),
                        );
                      }).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
