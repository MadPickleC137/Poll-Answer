// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:poll_answer/model/question.dart';
import 'package:poll_answer/theme/colors.dart';

class ProfileActiveQuizView extends StatelessWidget {
  List<Question> activeQuests = List.empty();
  ProfileActiveQuizView({required this.activeQuests});

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
