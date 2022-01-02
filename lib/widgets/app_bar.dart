// ignore_for_file: unnecessary_const, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:poll_answer/theme/colors.dart';
import 'package:poll_answer/widgets/decoration_app_bar.dart';

PreferredSizeWidget appBar(String title, BuildContext context) {
  return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 50.0),
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: decorationAppBar(),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              color: appBarTextColor,
            ),
          ),
        ),
      ));
}
