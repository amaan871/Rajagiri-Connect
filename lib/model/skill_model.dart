import 'dart:typed_data';

import 'package:rajagiri_connect/resources/StorageMethods.dart';

class SkillModel {
  // final String? uid;
  // final String? email;
  // final String? firstName;
  // final String? secondName;
  // final String? phone;
  final String? sem;
  final String? Class;
  final String? Division;
  // final String? skill;
  // final String? PhotoUrl;

  const SkillModel({
    //required this.uid,
    // required this.email,
    // required this.firstName,
    // required this.secondName,
    // required this.phone,
    required this.sem,
    required this.Class,
    required this.Division,
    // required this.skill,
    // required this.PhotoUrl
  });

  // factory UserModel.fromMap(map) {
  //   return UserModel(
  //       uid: map['uid'],
  //       email: map['email'],
  //       firstName: map['firstName'],
  //       secondName: map['secondName'],
  //       phone: map['phone'],
  //       sem: map['sem'],
  //       Class: map['Class'],
  //       Division: map['Division'],
  //       skill: map['skill'],
  //       PhotoUrl: map['photoUrl']);
  // }

  Map<String, dynamic> toJson() => {
        // 'uid': uid,
        // 'email': email,
        // 'firstName': firstName,
        // 'secondName': secondName,
        // 'phone': phone,
        'sem': sem,
        'Class': Class,
        'Division': Division,
        // 'skill': skill,
        // 'photoUrl': PhotoUrl
      };
}
