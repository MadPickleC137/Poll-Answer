import 'package:flutter/material.dart';

ButtonStyle buttonStyle(
    {required Color overlay,
    required Color background,
    Size size = const Size(100, 45),
    required BorderRadius borderRadius}) {
  return ButtonStyle(
    minimumSize: MaterialStateProperty.all(size),
    overlayColor: MaterialStateProperty.all(overlay),
    backgroundColor: MaterialStateProperty.all(background),
    shadowColor: MaterialStateProperty.all(Colors.transparent),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
    ),
  );
}
