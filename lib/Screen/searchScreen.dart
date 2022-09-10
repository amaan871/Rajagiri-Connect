import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rajagiri_connect/Screen/SkillProfile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isShowusers = false;
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 168, 11, 11),
          title: Form(
            child: TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
                  labelText: 'Enter the UID here', fillColor: Colors.black),
              onFieldSubmitted: (String _) {
                setState(() {
                  isShowusers = true;
                });
                print(_);
              },
            ),
          ),
        ),
        body: Container(
          child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('student')
                  .where('skill', isGreaterThanOrEqualTo: searchController.text)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen3(
                            uid: (snapshot.data! as dynamic).docs[index]['uid'],
                          ),
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              'https://img.collegepravesh.com/2022/04/RSET-Kochi-Logo.png'
                              // (snapshot.data! as dynamic).docs[index]
                              //     ['photoUrl']
                              ),
                        ),
                        title: Text(
                            (snapshot.data! as dynamic).docs[index]['email']),
                        subtitle: Row(
                          children: [
                            Text(
                              (snapshot.data! as dynamic).docs[index]
                                  ['firstName'],
                            ),
                            Text(' '),
                            Text(
                              (snapshot.data! as dynamic).docs[index]
                                  ['secondName'],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
        ));
  }
}
