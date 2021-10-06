import 'package:flutter/material.dart';

class MainScreenPage extends StatelessWidget {
  const MainScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    ));
  }
}
