import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FriendPostsFeed extends StatefulWidget {
  const FriendPostsFeed({super.key});

  @override
  State<FriendPostsFeed> createState() => _FriendPostsFeedState();
}

class _FriendPostsFeedState extends State<FriendPostsFeed> {
  String? currentUserId;
  String? currentUserTag;

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  Future<void> _initUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final userDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
    setState(() {
      currentUserId = user.uid;
      currentUserTag = userDoc.data()?['userTag'];
    });
  }

  Stream<List<Map<String, dynamic>>> _friendPostsStream() async* {
    if (currentUserTag == null) return;

    final userDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .get();
    List<dynamic> friends = List.from(userDoc.data()?['friends'] ?? []);

    if (!friends.contains(currentUserTag)) {
      friends.add(currentUserTag); // Include your own posts
    }

    if (friends.isEmpty) {
      yield [];
      return;
    }

    final query = FirebaseFirestore.instance
        .collection('posts')
        .where('userTag', whereIn: friends)
        .orderBy('timestamp', descending: true);

    yield* query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  Future<void> _toggleLike(Map<String, dynamic> post) async {
    final postId = post['id'];
    if (postId == null || currentUserId == null) return;

    final postRef = FirebaseFirestore.instance.collection('posts').doc(postId);
    final postSnapshot = await postRef.get();

    if (!postSnapshot.exists) {
      debugPrint("❌ Post not found for id: $postId");
      return;
    }

    List<dynamic> likedBy = List.from(post['likedBy'] ?? []);

    if (likedBy.contains(currentUserId)) {
      likedBy.remove(currentUserId);
    } else {
      likedBy.add(currentUserId);
    }

    await postRef.update({'likes': likedBy.length, 'likedBy': likedBy});
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserId == null || currentUserTag == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _friendPostsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text("No posts yet", style: TextStyle(color: Colors.white)),
          );
        }

        final posts = snapshot.data!;

        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            final isLiked = (post['likedBy'] ?? []).contains(currentUserId);

            return Card(
              color: const Color.fromARGB(255, 178, 151, 228),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          size: 20,
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          post['userTag'] ?? 'Unknown User',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(post['content'] ?? 'No content'),
                      subtitle: Text('Likes: ${post['likes'] ?? 0}'),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: isLiked ? Colors.red : Colors.grey,
                        ),
                        onPressed: () => _toggleLike(post),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
