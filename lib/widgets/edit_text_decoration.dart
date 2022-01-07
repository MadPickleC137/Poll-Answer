// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

InputDecoration textDecor(String title, IconData? icon) {
  return InputDecoration(
    contentPadding: EdgeInsets.all(10),
    isDense: true, // and add this line
    filled: true,
    fillColor: Color(0xD8AADDCD),
    counterText: "",
    prefixIcon: icon != null
        ? Container(
            margin: EdgeInsets.only(right: 6),
            decoration: BoxDecoration(
              color: Color(0xFF43CEA2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ))
        : null,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xD8AADDCD), width: 2.0),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xD8AADDCD), width: 2.0),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xD8AADDCD), width: 2.0),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    errorMaxLines: 1,
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFD82C2C), width: 2.0),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFD82C2C), width: 2.0),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFB4B4B6), width: 2.0),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    // labelText: title,
    label: Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        title,
        style: TextStyle(fontFamily: 'rubik', color: Color(0xFF1A5F9D)),
      ),
    ),
  );
}
