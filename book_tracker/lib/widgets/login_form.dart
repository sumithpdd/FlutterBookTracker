// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'input_decoration.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required this.formKey,
    required this.emailTextController,
    required this.passwordTextController,
  }) : super(key: key);
  final GlobalKey<FormState> formKey;
  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  @override
  Widget build(BuildContext context) {
    GlobalKey _scaffold = GlobalKey();
    return Form(
      key: formKey,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            validator: (value) {
              return value!.isEmpty ? 'Please add an email' : null;
            },
            controller: emailTextController,
            decoration: buildInputDecoration(
                label: 'Enter email', hintText: 'john@me.com'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
              validator: (value) {
                return value!.isEmpty ? 'Enter password' : null;
              },
              controller: passwordTextController,
              obscureText: true,
              decoration:
                  buildInputDecoration(label: 'password', hintText: '')),
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
            child: Text('Sign In'),
            style: TextButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                backgroundColor: Colors.amber,
                textStyle: TextStyle(fontSize: 18)),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                // FirebaseAuth.instance
                //     .signInWithEmailAndPassword(
                //         email: _emailTextController.text,
                //         password: _passwordTextController.text)
                //     .then((value) {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => MainScreenPage()));
                // }).catchError((onError) {
                //   return showDialog(
                //     context: context,
                //     builder: (context) {
                //       return AlertDialog(
                //         title: Text('Oops!'),
                //         content: Text('${onError.message}'),
                //       );
                //     },
                //   );
                // });
              }
            })
      ]),
    );
  }
}
