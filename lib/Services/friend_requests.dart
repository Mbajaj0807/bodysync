import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FriendService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<String> sendFriendRequest(String targetUserTag) async {
    final currentUserId = _auth.currentUser!.uid;

    final currentUserDoc = await _firestore.collection('users').doc(currentUserId).get();
    final currentUserTag = currentUserDoc['userTag'];

    // Find the user with the targetUserTag
    final result = await _firestore
        .collection('users')
        .where('userTag', isEqualTo: targetUserTag)
        .get();

    if (result.docs.isEmpty) return 'User not found';

    final targetUserDoc = result.docs.first;
    final targetUserId = targetUserDoc.id;

    // Update receiver's receivedRequests
    await _firestore.collection('users').doc(targetUserId).update({
      'receivedRequests': FieldValue.arrayUnion([currentUserTag])
    });

    // Update sender's sentRequests
    await _firestore.collection('users').doc(currentUserId).update({
      'sentRequests': FieldValue.arrayUnion([targetUserTag])
    });

    return 'Request sent!';
  }
}
