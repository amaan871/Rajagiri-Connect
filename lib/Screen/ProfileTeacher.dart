import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rajagiri_connect/Screen/LoginScreen.dart';
import 'package:rajagiri_connect/resources/auth_methods.dart';
import 'package:rajagiri_connect/utils/utils.dart';
import 'package:rajagiri_connect/widgets/follow.dart';

class ProfileScreen2 extends StatefulWidget {
  final String uid;
  const ProfileScreen2({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen2> createState() => _ProfileScreen2State();
}

class _ProfileScreen2State extends State<ProfileScreen2> {
  var userData = {};
  int postLen = 0;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('student')
          .doc(widget.uid)
          .get();

      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text('TEACHER PROFILE'),
              centerTitle: true,
            ),
            body: ListView(children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(userData['photoUrl']),
                        radius: 60,
                      ),
                      Expanded(
                        // flex: 2,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    buildStatColumn(postLen, "posts"),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              // mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FollowButton(
                                  backgroundColor:
                                      Color.fromARGB(255, 205, 50, 39),
                                  borderColor: Colors.grey,
                                  text: 'Sign Out',
                                  textColor: Colors.black,
                                  function: () async {
                                    await AuthMethods().signOut();
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(userData['firstName'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                        Text(' ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                        Text(userData['secondName'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(userData['email'],
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        )),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(userData['skill'],
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        )),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(userData['phone'],
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        )),
                  ),
                ]),
              ),
              const Divider(),
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .where('uid', isEqualTo: widget.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 1.5,
                          childAspectRatio: 1),
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];

                        return Container(
                          child: Image(
                              image: NetworkImage(
                            snap['postUrl'],
                          )),
                        );
                      },
                    );
                  })
            ]),
          );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
