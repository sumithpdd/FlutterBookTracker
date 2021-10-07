import 'package:book_tracker/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'input_decoration.dart';

class UpdateUserProfile extends StatelessWidget {
  final MUser user;
  final TextEditingController displayNameTextController;
  final TextEditingController profesionTextController;
  final TextEditingController quoteTextController;
  final TextEditingController avatarTextController;
  const UpdateUserProfile({
    Key? key,
    required this.user,
    required this.displayNameTextController,
    required this.profesionTextController,
    required this.quoteTextController,
    required this.avatarTextController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('Edit ${user.displayName}'),
      ),
      content: Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                      user.avatarUrl ?? 'https://i.pravatar.cc/300'),
                  radius: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: displayNameTextController,
                  decoration:
                      buildInputDecoration(label: 'Your name', hintText: ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: profesionTextController,
                  decoration:
                      buildInputDecoration(label: 'Profession', hintText: ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: quoteTextController,
                  decoration: buildInputDecoration(
                      label: 'Favorite quote', hintText: ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: avatarTextController,
                  decoration:
                      buildInputDecoration(label: 'Avatar url', hintText: ''),
                ),
              )
            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                final userChangedName =
                    user.displayName != displayNameTextController.text;

                final userChangedAvatar =
                    user.avatarUrl != avatarTextController.text;
                final userChangedProfession =
                    user.profession != profesionTextController.text;
                final userChangedQuote = user.quote != quoteTextController.text;

                final userNeedUpdate = userChangedName ||
                    userChangedAvatar ||
                    userChangedProfession ||
                    userChangedQuote;

                if (userNeedUpdate) {
                  // ignore: avoid_print
                  print('Updating...');
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.id)
                      .update(MUser(
                              uid: user.uid,
                              displayName: displayNameTextController.text,
                              avatarUrl: avatarTextController.text,
                              profession: profesionTextController.text,
                              quote: quoteTextController.text)
                          .toMap());
                }
                Navigator.of(context).pop();
              },
              child: const Text('Update')),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel')),
        )
      ],
    );
  }
}
