// ignore_for_file: prefer_const_constructors

import 'package:book_tracker/model/book.dart';
import 'package:book_tracker/model/user.dart';
import 'package:book_tracker/widgets/create_profile_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class MainScreenPage extends StatelessWidget {
  const MainScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference userCollectionReference =
        FirebaseFirestore.instance.collection('users');
    CollectionReference bookCollectionReference =
        FirebaseFirestore.instance.collection('books');

    var authUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        elevation: 0.0,
        toolbarHeight: 77,
        centerTitle: false,
        title: Row(
          children: [
            Image.asset(
              'assets/images/Icon-76.png',
              scale: 2,
            ),
            Text(
              'A.Reader',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.redAccent, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          (authUser != null)
              ? StreamBuilder<QuerySnapshot>(
                  stream: userCollectionReference.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final userListStream = snapshot.data!.docs.map((user) {
                      return MUser.fromDocument(user);
                    }).where((user) {
                      return (user.uid == authUser.uid);
                    }).toList(); //[user]

                    MUser curUser = userListStream[0];

                    return Column(
                      children: [
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: InkWell(
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(curUser.avatarUrl ??
                                  'https://i.pravatar.cc/300'),
                              backgroundColor: Colors.white,
                              child: Text(''),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  // return createProfileMobile(context, userListStream,
                                  //     FirebaseAuth.instance.currentUser, null);
                                  return createProfileDialog(
                                      context, curUser, <Book>[]);
                                },
                              );
                            },
                          ),
                        ),
                        Text(
                          curUser.displayName!.toUpperCase(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    );
                  },
                )
              : Container(),
          TextButton.icon(
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then((value) {
                  return Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                }, onError: (error) {
                  print(error.toString());
                });
              },
              icon: Icon(Icons.logout),
              label: Text(''))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: bookCollectionReference.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final bookListStream = snapshot.data!.docs.map((book) {
            return Book.fromDocument(book);
          }).toList();
          return ListView.builder(
              itemCount: bookListStream.length,
              itemBuilder: (context, index) {
                return Text(bookListStream[index].title,
                    style: TextStyle(
                        overflow: TextOverflow.fade,
                        color: Color(0xFF393939),
                        fontWeight: FontWeight.bold));
              });
        },
      ),
    );
  }
}
