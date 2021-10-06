// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainScreenPage extends StatelessWidget {
  const MainScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference bookCollectionReference =
        FirebaseFirestore.instance.collection('books');

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
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.redAccent, fontWeight: FontWeight.bold),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: bookCollectionReference.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              Map<String, dynamic> data =
                  snapshot.data!.docs.first.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(data['title'],
                    style: TextStyle(
                        overflow: TextOverflow.fade,
                        color: Color(0xFF393939),
                        fontWeight: FontWeight.bold)),
              );
            },
          )
        ],
      ),
    ));
  }
}
