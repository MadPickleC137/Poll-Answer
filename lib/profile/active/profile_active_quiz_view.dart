import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poll_answer/theme/colors.dart';

class ProfileActiveQuizView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: backgroundColor,
      body: Container(
        child: Center(
          child: Text("Active Quiestions"),
        ),
      ),
    );
  }
}
