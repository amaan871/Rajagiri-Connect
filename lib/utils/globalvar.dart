import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rajagiri_connect/Screen/AddPost.dart';
import 'package:rajagiri_connect/Screen/Feed.dart';
import 'package:rajagiri_connect/Screen/Feed2.dart';
import 'package:rajagiri_connect/Screen/ProfileScreen.dart';
import 'package:rajagiri_connect/Screen/ProfileTeacher.dart';
import 'package:rajagiri_connect/Screen/searchScreen.dart';

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const AddPostScreen(),
  const SearchScreen(),
  ProfileScreen2(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
  FeedScreen2(),
];

List<Widget> homeScreenItems2 = [
  const FeedScreen(),
  const SearchScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
  FeedScreen2()
];
