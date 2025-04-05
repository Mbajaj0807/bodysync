import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendRequestDialog {
  static void show(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final userDoc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

    List<dynamic> requests = [];
    var rawRequests = userDoc.data()?['friendRequests'];

    if (rawRequests is List) {
      requests = List<String>.from(rawRequests);
    } else if (rawRequests is String) {
      requests = [rawRequests];
    }

    print('[DEBUG] Current user UID: ${user.uid}');
    print('[DEBUG] Friend requests fetched: $requests');

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Color.fromRGBO(35, 35, 35, 1),

              title: const Text(
                'Friend Requests',
                style: TextStyle(color: Colors.white),
              ),
              content:
                  requests.isEmpty
                      ? const Text(
                        'No pending requests',
                        style: TextStyle(color: Colors.white),
                      )
                      : SizedBox(
                        width: double.maxFinite,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: requests.length,
                          itemBuilder: (context, index) {
                            String senderUid = requests[index];

                            return FutureBuilder<DocumentSnapshot>(
                              future:
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(senderUid)
                                      .get(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const ListTile(
                                    title: Text(
                                      'Loading...',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }

                                if (!snapshot.hasData ||
                                    !snapshot.data!.exists) {
                                  return const ListTile(
                                    title: Text(
                                      'User not found',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }

                                final senderData =
                                    snapshot.data!.data()
                                        as Map<String, dynamic>?;

                                String senderTag =
                                    senderData != null &&
                                            senderData.containsKey('userTag')
                                        ? senderData['userTag']
                                        : 'Unknown';

                                return ListTile(
                                  title: Text(
                                    senderTag,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        ),
                                        onPressed: () async {
                                          await _handleFriendRequest(
                                            currentUid: user.uid,
                                            senderUid: senderUid,
                                            accept: true,
                                          );
                                          setState(() {
                                            requests.removeAt(index);
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                        onPressed: () async {
                                          await _handleFriendRequest(
                                            currentUid: user.uid,
                                            senderUid: senderUid,
                                            accept: false,
                                          );
                                          setState(() {
                                            requests.removeAt(index);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  static Future<void> _handleFriendRequest({
    required String currentUid,
    required String senderUid,
    required bool accept,
  }) async {
    final firestore = FirebaseFirestore.instance;

    try {
      final currentUserDoc =
          await firestore.collection('users').doc(currentUid).get();
      final currentUserTag = currentUserDoc.data()?['userTag'];

      print('[DEBUG] Accepting request from $senderUid');
      print('[DEBUG] Current userTag: $currentUserTag');

      final senderDoc =
          await firestore.collection('users').doc(senderUid).get();

      if (!senderDoc.exists || currentUserTag == null) {
        print('[ERROR] Sender does not exist or current userTag is null');
        return;
      }

      final senderTag = senderDoc.data()?['userTag'];
      print('[DEBUG] Sender UID: $senderUid');
      print('[DEBUG] Sender userTag: $senderTag');

      final currentUserRef = firestore.collection('users').doc(currentUid);
      final senderRef = firestore.collection('users').doc(senderUid);

      if (accept) {
        await currentUserRef.update({
          'friends': FieldValue.arrayUnion([senderTag]),
          'friendRequests': FieldValue.arrayRemove([senderUid]),
        });

        await senderRef.update({
          'friends': FieldValue.arrayUnion([currentUserTag]),
        });

        print('[SUCCESS] Friend request accepted');
      } else {
        await currentUserRef.update({
          'friendRequests': FieldValue.arrayRemove([senderUid]),
        });

        print('[SUCCESS] Friend request rejected');
      }
    } catch (e) {
      print('[EXCEPTION] Error handling friend request: $e');
    }
  }
}
