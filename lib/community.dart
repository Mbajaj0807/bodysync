import 'package:bodysync/post_feed.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'friend_request_send.dart';
import 'friend_request_show.dart';

class Community extends StatelessWidget {
  const Community({super.key});

  void _showCreatePostDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: const Color.fromARGB(255, 240, 240, 255),
            title: const Text("Create Post"),
            content: TextField(
              controller: controller,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "What's on your mind?",
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: const Text("Post"),
                onPressed: () async {
                  final content = controller.text.trim();
                  if (content.isEmpty) return;

                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    // Fetch userTag from Firestore
                    final userDoc =
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .get();

                    final userTag = userDoc.data()?['userTag'];

                    if (userTag != null) {
                      await FirebaseFirestore.instance.collection('posts').add({
                        'uid': user.uid,
                        'userTag': userTag, // Add this
                        'content': content,
                        'timestamp': Timestamp.now(),
                        'likes': 0,
                        'likedBy': [],
                      });
                    }
                  }

                  Navigator.pop(context);
                },
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Community',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color.fromRGBO(137, 108, 254, 1),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              FriendRequestDialog.show(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              FriendRequestDialogHelper.show(context);
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
      body: const FriendPostsFeed(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreatePostDialog(context),
        backgroundColor: const Color.fromRGBO(137, 108, 254, 1),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
