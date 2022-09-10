import 'dart:ffi';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rajagiri_connect/model/user_model.dart' as model;
import 'package:rajagiri_connect/resources/StorageMethods.dart';

import '../Screen/Skills.dart';
import '../model/user_model.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.UserModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('student').doc(currentUser.uid).get();

    return model.UserModel.fromSnap(documentSnapshot);
  }

  // Future<String> signUser({
  //   required String email,
  //   required String password,
  //   // required String FirstName,
  //   // required String LastName,
  //   // required String Phone,
  //   required Uint8List file,
  // }) async {
  //   String res = "Some error occured";
  //   try {
  //     if (email.isNotEmpty || password.isNotEmpty || file != null) {
  //       UserCredential cred = await _auth.createUserWithEmailAndPassword(
  //           email: email, password: password);
  //       print(cred.user!.uid);
  //       String photoUrl = await StorageMethods()
  //           .uploadImageToStorage('profilePics', file, false);

  //       model.UserModel userModel = model.UserModel(
  //           uid: cred.user!.uid,
  //           email: email,
  //           firstName: FirstName,
  //           secondName: LastName,
  //           phone: Phone,
  //           // sem: ,
  //           // Class: [],
  //           // Division: [],
  //           // skill: [],
  //           PhotoUrl: photoUrl);

  //       await _firestore
  //           .collection("student")
  //           .doc(cred.user!.uid)
  //           .set(userModel.toJson());

  //       // Fluttertoast.showToast(msg: "Account created Successfully");

  //     } else {
  //       res = "Please enter all the fields";
  //     }
  //   } catch (err) {
  //     res = err.toString();
  //   }
  //   return res;
  // }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  var userData = {};
  Future<String> getdata() async {
    User? user = _auth.currentUser!;
    String id = '';
    var db = await FirebaseFirestore.instance
        .collection('posts')
        .doc(user.uid)
        .get();
    userData = db.data()!;
    id = userData['role'];
    return id;
  }
}
