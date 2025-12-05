
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static const _lockTimeout = Duration(minutes: 2);

  Stream<DocumentSnapshot> getUserProfile() {
    final user = _auth.currentUser;
    if (user != null) {
      return _firestore.collection('users').doc(user.uid).snapshots();
    } else {
      throw Exception('No user logged in');
    }
  }

  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    final user = _auth.currentUser;
    if (user != null) {
      final dataWithTimestamp = {
        ...data,
        'profileEditedAt': FieldValue.serverTimestamp(),
      };
      await _firestore.collection('users').doc(user.uid).update(dataWithTimestamp);
    } else {
      throw Exception('No user logged in');
    }
  }

  Future<bool> startEditing() async {
    final user = _auth.currentUser;
    if (user == null) {
      return false;
    }
    final docRef = _firestore.collection('users').doc(user.uid);

    try {
      return await _firestore.runTransaction<bool>((transaction) async {
        final snapshot = await transaction.get(docRef);
        final data = snapshot.data();

        if (data != null && data['isEditing'] == true) {
          final lockTimestamp = data['lockTimestamp'] as Timestamp?;
          if (lockTimestamp != null &&
              DateTime.now().difference(lockTimestamp.toDate()) < _lockTimeout) {
            return false; // Profile is locked
          }
        }

        transaction.update(docRef, {
          'isEditing': true,
          'lockTimestamp': FieldValue.serverTimestamp(),
        });
        return true; // Lock acquired successfully
      });
    } catch (e) {
      return false;
    }
  }

  Future<void> finishEditing() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .update({'isEditing': false, 'lockTimestamp': null});
    }
  }
}
