import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FriendRequestDialogHelper {
  static void show(BuildContext context) {
    final TextEditingController tagController = TextEditingController();
    final currentUser = FirebaseAuth.instance.currentUser;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
          title: const Text(
            'Send Friend Request',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: tagController,
            decoration: const InputDecoration(
              hintText: 'Enter userTag',
              hintStyle: TextStyle(color: Colors.grey),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final enteredTag = tagController.text.trim();

                if (enteredTag.isEmpty || currentUser == null) return;

                try {
                  final querySnapshot =
                      await FirebaseFirestore.instance
                          .collection('users')
                          .where('userTag', isEqualTo: enteredTag)
                          .limit(1)
                          .get();

                  if (querySnapshot.docs.isEmpty) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('User not found')),
                    );
                    return;
                  }

                  final targetUser = querySnapshot.docs.first;
                  final targetUserId = targetUser.id;

                  // Add friend request to target user's "friendRequests" field
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(targetUserId)
                      .update({
                        'friendRequests': FieldValue.arrayUnion([
                          currentUser.uid,
                        ]),
                      });

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Friend request sent')),
                  );
                } catch (e) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Error: $e')));
                }
              },
              child: const Text('Send', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
          ],
        );
      },
    );
  }
}
