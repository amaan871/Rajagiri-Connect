import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rajagiri_connect/resources/StorageMethods.dart';

class UserModel {
  final String uid;
  final String? email;
  final String firstName;
  final String? secondName;
  final String? phone;
  // final String? sem;
  // final String? Class;
  // final String? Division;
  // final String? skill;
  final String? PhotoUrl;
  final String? role;
  final String? skill;

  const UserModel(
      {required this.uid,
      required this.email,
      required this.firstName,
      required this.secondName,
      required this.phone,
      // required this.sem,
      // required this.Class,
      // required this.Division,
      // required this.skill,
      required this.PhotoUrl,
      required this.role,
      required this.skill});

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
        uid: snapshot['uid'],
        email: snapshot['email'],
        firstName: snapshot['firstName'],
        secondName: snapshot['secondName'],
        phone: snapshot['phone'],
        // sem: map['sem'],
        // Class: map['Class'],
        // Division: map['Division'],
        // skill: map['skill'],
        PhotoUrl: snapshot['photoUrl'],
        role: snapshot['role'],
        skill: snapshot['skill']);
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'firstName': firstName,
        'secondName': secondName,
        'phone': phone,
        // 'sem': sem,
        // 'Class': Class,
        // 'Division': Division,
        // 'skill': skill,
        'photoUrl': PhotoUrl,
        'role': role,
        'skill': skill
      };
}
