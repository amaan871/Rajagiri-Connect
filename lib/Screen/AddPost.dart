import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rajagiri_connect/model/user_model.dart';
import 'package:rajagiri_connect/provider/user_provider.dart';
import 'package:rajagiri_connect/resources/firestoreMethod.dart';
import 'package:rajagiri_connect/utils/utils.dart';
import 'package:snippet_coder_utils/multi_images_utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController SecondNameEditingController =
      TextEditingController();
  bool isLoading = false;

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
          _descriptionController.text, _file!, uid, username, profImage);
      if (res == "Success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, 'Posted!');
        clearImage();
      } else {
        showSnackBar(context, 'failed');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, e.toString());
    }
  }

  void postDesc(
      String uid, String username, String secname, String profImage) async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadDesc(
          _descriptionController.text, uid, username, secname, profImage);
      if (res == "Success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, 'Posted!');
        clearImage();
      } else {
        showSnackBar(context, 'failed');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, e.toString());
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(title: const Text('Create a Post'), children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Take a Photo'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(
                  ImageSource.camera,
                );
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Choose from Gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(
                  ImageSource.gallery,
                );
                setState(() {
                  _file = file;
                });
              },
            ),
          ]);
        });
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  String username = "";
  String id = "";
  String photourl = "";

  String secname = "";

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('student')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['firstName'];
      id = FirebaseAuth.instance.currentUser!.uid;
      photourl = (snap.data() as Map<String, dynamic>)['photoUrl'];
      secname = (snap.data() as Map<String, dynamic>)['secondName'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Center(child: Text('$photoUrl')),
    // );

    // final UserModel user = Provider.of<UserProvider>(context).getUser;

    return _file == null
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text("ADD POST"),
              foregroundColor: Colors.white,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1.0,
                    child: TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                          hintText: "Enter Description here",
                          contentPadding: const EdgeInsets.only(left: 20),
                          border: InputBorder.none),
                      maxLines: 8,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.red[700],
                    child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: (() =>
                          postDesc(id, username, secname, photourl)),
                      child: Container(
                        child: !isLoading
                            ? Text(
                                "Post",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            : const LinearProgressIndicator(
                                color: Colors.white,
                              ),
                      ),
                    ),
                  ),
                  const Divider(),
                  SizedBox(
                    height: 150,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        // padding: const EdgeInsets.only(right: 20, top: 40),
                        icon: const Icon(Icons.upload),
                        color: Colors.black,
                        onPressed: () => _selectImage(context),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: clearImage,
              ),
              title: const Text("POST TO"),
              foregroundColor: Colors.white,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 170,
                        width: 170,
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: MemoryImage(_file!),
                              fit: BoxFit.scaleDown,
                              alignment: FractionalOffset.topCenter,
                            )),
                          ),
                        ),
                      ),
                      SizedBox(
                          // width: MediaQuery.of(context).size.width * 0.49,
                          child: TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Write the Information here',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                        ),
                        maxLines: 8,
                      )),
                    ],
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.red[700],
                    child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: (() => postImage(
                            id,
                            username,
                            photourl,
                          )),
                      child: Container(
                        child: !isLoading
                            ? Text(
                                "Post",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            : const LinearProgressIndicator(
                                color: Colors.white,
                              ),
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ));
  }
}
