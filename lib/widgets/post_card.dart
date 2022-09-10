import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:rajagiri_connect/resources/auth_methods.dart';
import 'package:rajagiri_connect/resources/firestoreMethod.dart';

class PostCard extends StatelessWidget {
  final snap;

  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isloading = false;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    snap['profImage'],
                    // 'https://cdn.pixabay.com/photo/2016/07/07/16/46/dice-1502706__340.jpg',
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snap['username'],
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
                // IconButton(
                //   onPressed: () {
                //     showDialog(
                //         context: context,
                //         builder: (context) => Dialog(
                //               child: ListView(
                //                 padding: const EdgeInsets.symmetric(
                //                   vertical: 16,
                //                 ),
                //                 shrinkWrap: true,
                //                 children: [
                //                   'Delete',
                //                 ]
                //                     .map(
                //                       (e) => InkWell(
                //                         onTap: () async {
                //                           FirestoreMethods().deletePost(
                //                             snap['postId'].toString(),
                //                           );
                //                           Navigator.of(context).pop();
                //                         },
                //                         child: Container(
                //                           padding: const EdgeInsets.symmetric(
                //                               vertical: 12, horizontal: 16),
                //                           child: Text(e),
                //                         ),
                //                       ),
                //                     )
                //                     .toList(),
                //               ),
                //             ));
                //   },
                //   icon: const Icon(Icons.more_vert),
                // )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            child: Image.network(
              snap['postUrl'],
              //'https://cdn.pixabay.com/photo/2016/07/07/16/46/dice-1502706__340.jpg',
              fit: BoxFit.scaleDown,
            ),
          ),
          // Row(
          //   children: [
          //     IconButton(
          //         onPressed: () {},
          //         icon: const Icon(Icons.favorite_outline_outlined))
          //   ],
          // ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // DefaultTextStyle(
                //   style: Theme.of(context)
                //       .textTheme
                //       .subtitle2!
                //       .copyWith(fontWeight: FontWeight.bold),
                //   child: Text(
                //     '${snap['likes'].length} likes',
                //     style: Theme.of(context).textTheme.bodyText2,
                //   ),
                // ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(text: ''),
                        TextSpan(
                          text: ' ',
                        ),
                        TextSpan(
                          text: snap['description'],
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    DateFormat.yMMMd().format(
                      snap['datePublished'].toDate(),
                    ),
                    style: const TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
