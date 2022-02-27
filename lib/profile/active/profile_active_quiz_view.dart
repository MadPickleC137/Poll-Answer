// ignore_for_file: use_key_in_widget_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:poll_answer/core/utils/constants.dart';
import 'package:poll_answer/core/utils/scroll_mode.dart';
import 'package:poll_answer/model/question.dart';
import 'package:poll_answer/profile/profile_controller.dart';
import 'package:poll_answer/profile/profile_view.dart';
import 'package:poll_answer/quiz_list/carousel_indicator.dart';
import 'package:poll_answer/theme/app_theme.dart';
import 'package:poll_answer/theme/colors.dart';
import 'package:poll_answer/widgets/button_style.dart';

class ProfileActiveQuizView extends StatelessWidget {
  ProfileActiveQuizView({required this.activeQuests});
  List<Question> activeQuests = [];
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: backgroundColor,
      body: ScrollConfiguration(
        behavior: DisableGlowBehavior(),
        child: activeQuests.isNotEmpty
            ? ListView.builder(
                itemCount: activeQuests.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(
                        top: 4, left: 6, right: 6, bottom: 10),
                    decoration: const BoxDecoration(
                      color: startColorAppBar,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: itemQuestion(index),
                  );
                },
              )
            : emptyQuestions(),
      ),
    );
  }

  Column itemQuestion(int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
          child: Text(
            activeQuests[index].title.toString(),
            textAlign: TextAlign.center,
            style: titleTextStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            activeQuests[index].description.toString(),
            textAlign: TextAlign.justify,
            style: normalTextStyle,
            overflow: TextOverflow.visible,
          ),
        ),
        CarouselIndicator(
          count: 3,
          selected: 6,
          colorIndicator: indicatorColor,
        ),
        actionButtonWidget(activeQuests[index])
      ],
    );
  }

  Container actionButtonWidget(Question question) {
    return Container(
      height: buttonHeight,
      decoration: const BoxDecoration(
        gradient: buttonGradientType1,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: buttonShadowType1,
      ),
      child: TextButton(
        style: buttonStyle(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          overlay: overlayButtonType1,
          background: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(tr('action'), style: buttonTextStyle),
            ),
            Spacer(),
            Image.asset(
              'assets/img/ic_action_quiz.png',
              width: 30,
              height: 28,
            ),
          ],
        ),
        onPressed: () {
          controller.showActionDialog(question);
        },
      ),
    );
  }
}
