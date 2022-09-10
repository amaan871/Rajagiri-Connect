import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rajagiri_connect/model/post.dart';
import 'package:rajagiri_connect/widgets/post_NoIm.dart';
import 'package:rajagiri_connect/widgets/post_card.dart';

class FeedScreen2 extends StatelessWidget {
  const FeedScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset(
          'lib/asset/logo2.png',
          color: Color.fromARGB(255, 123, 30, 23),
          height: 70,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('notice').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => PostCard2(
              snap2: snapshot.data!.docs[index].data(),
            ),
          );
        },
      ),
    );
  }
}
