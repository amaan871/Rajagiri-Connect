import 'package:cloud_firestore/cloud_firestore.dart';

class Post1 {
  final String description;
  final String uid;
  final String username;
  final likes;
  final String postId;
  final DateTime datePublished;
  final String Secname;
  final String profImage;
  final String role;

  const Post1({
    required this.description,
    required this.uid,
    required this.username,
    required this.likes,
    required this.postId,
    required this.datePublished,
    required this.Secname,
    required this.profImage,
    required this.role,
  });

  static Post1 fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post1(
        description: snapshot["description"],
        uid: snapshot["uid"],
        likes: snapshot["likes"],
        postId: snapshot["postId"],
        datePublished: snapshot["datePublished"],
        username: snapshot["username"],
        Secname: snapshot['Secname'],
        profImage: snapshot['profImage'],
        role: snapshot['role']);
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "likes": likes,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        'Secname': Secname,
        'profImage': profImage,
        'role': role
      };
}
