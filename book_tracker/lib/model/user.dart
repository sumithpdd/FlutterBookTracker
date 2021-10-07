import 'package:cloud_firestore/cloud_firestore.dart';

class MUser {
  final String? id;
  final String uid;
  final String? displayName;
  final String? quote;
  final String? profession;
  final String? avatarUrl;

  MUser(
      {this.id,
      required this.uid,
      this.displayName,
      this.quote,
      this.profession,
      this.avatarUrl});

  factory MUser.fromDocument(QueryDocumentSnapshot doc) {
    return MUser(
      id: doc.id,
      uid: (doc.data() as dynamic)['uid'],
      displayName: (doc.data() as dynamic)['display_name'],
      quote: (doc.data() as dynamic)['quote'],
      profession: (doc.data() as dynamic)['profession'],
      avatarUrl: (doc.data() as dynamic)['avatar_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'display_name': displayName,
      'quote': quote,
      'profession': profession,
      'avatar_url': avatarUrl,
    };
  }
}
