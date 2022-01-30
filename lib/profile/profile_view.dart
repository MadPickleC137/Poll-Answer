// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:poll_answer/profile/active/profile_active_quiz_view.dart';
import 'package:poll_answer/profile/closed/profile_closed_quiz_view.dart';
import 'package:poll_answer/profile/profile_controller.dart';
import 'package:poll_answer/theme/colors.dart';
import 'package:poll_answer/widgets/button_style.dart';
import 'package:poll_answer/widgets/decoration_app_bar.dart';

class ProfileView extends StatelessWidget {
  final _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: appBar(context),
        body: _segmentsPages[controller.groupValue],
      );
    });
  }

  PreferredSize appBar(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: Size(width, 90),
      child: Container(
        height: 90,
        width: double.infinity,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: decorationAppBar(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    tr('my_quiz'),
                    style: TextStyle(
                      fontFamily: 'rubik',
                      fontSize: 16,
                      color: appBarTextColor2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: buttonStyle(
                      background: Colors.transparent,
                      overlay: appBarButtonOverlay,
                      size: Size(24, 24),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.info_outline_rounded,
                      color: appBarIconColor,
                    ),
                    onPressed: () {
                      _controller.navigateToInfo();
                    },
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.only(top: 2, bottom: 4),
              alignment: Alignment.topCenter,
              child: CupertinoSlidingSegmentedControl<int>(
                backgroundColor: slidingBackgroundColor,
                thumbColor: startColorAppBar,
                padding: EdgeInsets.all(4),
                groupValue: _controller.groupValue,
                children: {
                  0: segmentsTitle(tr('active-quiz')),
                  1: segmentsTitle(tr('closed-quiz')),
                },
                onValueChanged: (value) {
                  _controller.onChangeSegment(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget segmentsTitle(String title) {
    return Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        width: 200,
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
              fontFamily: 'rubik', fontSize: 14, color: appBarTextColor2),
        ));
  }

  final List<Widget> _segmentsPages = [
    ProfileActiveQuizView(),
    ProfileClosedQuizView(),
  ];
}
