import 'package:flutter/cupertino.dart';
import 'package:poll_answer/theme/colors.dart';

BoxDecoration decorationAppBar() {
  return const BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(14),
        bottomRight: Radius.circular(14),
      ),
      gradient: LinearGradient(colors: [
        startColorAppBar,
        endColorAppBar,
      ]),
      boxShadow: [
        BoxShadow(
            color: endColorAppBar,
            blurRadius: 30.0,
            spreadRadius: 4,
            offset: Offset(0.0, 0.75))
      ]);
}
