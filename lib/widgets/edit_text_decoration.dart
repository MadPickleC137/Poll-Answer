// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

InputDecoration textDecor(String title, IconData? icon) {
  return InputDecoration(
    contentPadding: EdgeInsets.all(10),
    isDense: true, // and add this line
    filled: true,
    fillColor: Color(0x770F1E26),
    counterText: "",
    prefixIcon: icon != null
        ? Container(
            margin: EdgeInsets.only(right: 6),
            decoration: BoxDecoration(
              color: Color(0xBE0F1E26),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ))
        : null,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xD86E8899), width: 1.5),
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFBFE5FF), width: 1.5),
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF6E8899), width: 1.5),
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    errorMaxLines: 1,
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFE44242), width: 1.5),
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFE44242), width: 1.5),
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF61686D), width: 1.5),
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    // labelText: title,
    label: Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        title,
        style: TextStyle(fontFamily: 'rubik', color: Color(0xFF6E8899)),
      ),
    ),
  );
}
