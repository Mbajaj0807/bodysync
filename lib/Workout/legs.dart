import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bodysync/widgets/exercise_card.dart';

class LegsWorkout extends StatelessWidget {
  const LegsWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 35, 35, 1),
      appBar: AppBar(
        title: Text('Legs'),
        backgroundColor: Color.fromRGBO(137, 108, 254, 1),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
        FirebaseFirestore.instance
            .collection('workouts')
            .doc('legs')
            .collection('items')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No exercises found'));
          }

          final exercises = snapshot.data!.docs;

          return SingleChildScrollView(
            child: Column(
              children:
              exercises.map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return ExerciseCard(
                  exerciseName: data['name'] ?? 'Unknown',
                  time: data['time'] ?? '0min',
                  calories: data['calories']?.toString() ?? '0',
                  imagePath: data['image'] ?? 'assets/legs.jpg',
                  onTap: () {
                    // Handle tap if needed
                  },
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
