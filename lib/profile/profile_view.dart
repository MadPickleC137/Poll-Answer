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
import 'package:poll_answer/widgets/decoration_app_bar.dart';

class ProfileView extends StatelessWidget {
  final _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
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
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  tr('my_quiz'),
                  style: TextStyle(
                    fontFamily: 'rubik',
                    fontSize: 18,
                    color: appBarTextColor,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.only(top: 14),
              alignment: Alignment.topCenter,
              child: CupertinoSlidingSegmentedControl<int>(
                backgroundColor: whiteColor,
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
              fontFamily: 'rubik', fontSize: 14, color: tabBarTextColor),
        ));
  }

  List<Widget> _segmentsPages = [
    ProfileActiveQuizView(),
    ProfileClosedQuizView(),
  ];
}
