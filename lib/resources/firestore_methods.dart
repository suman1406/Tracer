import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> saveUserData(String uid, String name, String email, String phoneNumber) async {
    try {
      final userData = {
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
      };
      await FirebaseFirestore.instance.collection('users').doc(uid).set(userData);
      return 'User data saved successfully';
    } catch (err) {
      if (kDebugMode) {
        print('Error');
      }
      return 'Failed to save user data';
    }
  }
}
