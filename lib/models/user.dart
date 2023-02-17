import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class User{
  final String email;
  final String name;
  final String phoneNumber;
  final String uid;

  const User(
      {required this.name,
        required this.uid,
        required this.phoneNumber,
        required this.email,
      });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      name: snapshot["name"],
      uid: snapshot["uid"],
      phoneNumber: snapshot["phoneNumber"],
      email: snapshot["email"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "uid" : uid,
    "email": email,
    "phoneNumber": phoneNumber
  };
}
