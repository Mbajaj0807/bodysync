import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void updateDetailsDialog(BuildContext context) {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();



  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * .45,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const Text(
                      "Enter Updated Weight",
                      style: TextStyle(
                        color: Color.fromRGBO(226, 241, 99, 1),
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: Color.fromRGBO(137, 108, 254, 1),
                      ),
                      decoration: const InputDecoration(
                        hintText: "Weight in kg",
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(137, 108, 254, 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(137, 108, 254, 1),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(137, 108, 254, 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "Enter Updated Height",
                      style: TextStyle(
                        color: Color.fromRGBO(226, 241, 99, 1),
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: heightController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: Color.fromRGBO(137, 108, 254, 1),
                      ),
                      decoration: const InputDecoration(
                        hintText: "Height in cm",
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(137, 108, 254, 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(137, 108, 254, 1),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(137, 108, 254, 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      double? weight = double.tryParse(weightController.text);
                      double? height = double.tryParse(heightController.text);
                      User? user = FirebaseAuth.instance.currentUser;

                      if (weight != null && height != null && user != null) {
                        try {
                          final userRef = FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid);

                          final docSnapshot = await userRef.get();
                          final data = docSnapshot.data();

                          if (data != null &&
                              data['age'] != null &&
                              data['gender'] != null) {
                            int age = data['age'];
                            String gender = data['gender'];

                            // Recalculate maintenance calories
                            double bmr;
                            if (gender == "Male") {
                              bmr =
                                  (10 * weight) +
                                  (6.25 * height) -
                                  (5 * age) +
                                  5;
                            } else {
                              bmr =
                                  (10 * weight) +
                                  (6.25 * height) -
                                  (5 * age) -
                                  161;
                            }
                            double maintenanceCalories = bmr * 1.55;

                            // Update weight, height, and maintenance calories
                            await userRef.update({
                              'weight': weight,
                              'height': height,
                              'maintenanceCalories':
                                  maintenanceCalories.round(),
                            });

                            // Append weight log
                            await userRef.update({
                              'weightLogs': FieldValue.arrayUnion([
                                {
                                  'weight': weight,
                                  'timestamp': Timestamp.now(),
                                },
                              ]),
                            });

                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Details updated successfully"),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Missing age or gender in profile",
                                ),
                              ),
                            );
                          }
                        } catch (e) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error: ${e.toString()}")),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please enter valid values"),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(137, 108, 254, 1),
                    ),
                    child: const Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),


  );
}
