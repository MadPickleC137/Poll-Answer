// ignore_for_file: unnecessary_const, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:poll_answer/theme/colors.dart';
import 'package:poll_answer/widgets/button_style.dart';
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
              fontFamily: 'rubik',
              fontSize: 18,
              color: appBarTextColor,
            ),
          ),
        ),
      ));
}

PreferredSize appBarBackButton(
    String title, BuildContext context, Function action) {
  double width = MediaQuery.of(context).size.width;
  return PreferredSize(
    preferredSize: Size(width, 50),
    child: Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: decorationAppBar(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          TextButton(
            style: buttonStyle(
              background: Colors.transparent,
              overlay: appBarButtonOverlay,
              size: Size(35, 35),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: appBarIconColor,
            ),
            onPressed: () {
              action();
            },
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'rubik',
                  fontSize: 18,
                  color: appBarTextColor2,
                ),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    ),
  );
}
