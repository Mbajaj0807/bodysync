import 'package:flutter/material.dart';

class GymFeatures {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // Tap outside to close if you want
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color.fromRGBO(35, 35, 35, .8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'We offer Following services:\n\n- Manage Your Subscriptions online\n- Track your Revenue\n- Manage Your Staff\n- Service',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                  },
                  child: const Text('Go Ahead'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
