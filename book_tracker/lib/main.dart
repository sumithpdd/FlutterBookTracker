import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/get_started_page.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    Widget widget;
    if (firebaseUser != null) {
      widget = const MainScreenPage();
    } else {
      widget = const GetStartedPage();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BookTracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: widget,
    );
  }
}
