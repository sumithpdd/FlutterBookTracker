// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(
    {required String label, required String hintText}) {
  return InputDecoration(
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Color(0xff69639F), width: 2.0)),
      labelText: label,
      hintText: hintText);
}
