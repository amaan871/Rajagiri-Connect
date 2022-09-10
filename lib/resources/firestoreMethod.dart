import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rajagiri_connect/model/post.dart';
import 'package:rajagiri_connect/model/postNoIm.dart';
import 'package:rajagiri_connect/resources/StorageMethods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String description,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = "Some Error occured";

    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1();
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          likes: [],
          datePublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage);

      _firestore.collection('posts').doc().set(post.toJson());
      res = "Success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> deleteNotice(String postId) async {
    try {
      await _firestore.collection('notice').doc(postId).delete();
    } catch (err) {
      print(err.toString());
    }
  }

  Future<String> uploadDesc(
    String description,
    String uid,
    String username,
    String Secname,
    String profImage,
  ) async {
    String res = "Some Error occured";
    String role = "noimage";
    try {
      String postId = const Uuid().v1();
      Post1 post = Post1(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          likes: [],
          datePublished: DateTime.now(),
          Secname: Secname,
          profImage: profImage,
          role: role);

      _firestore.collection('notice').doc().set(post.toJson());
      res = "Success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
