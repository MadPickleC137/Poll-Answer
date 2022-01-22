// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:poll_answer/api/api_response.dart';
import 'package:poll_answer/core/utils/scroll_mode.dart';
import 'package:poll_answer/model/category.dart';
import 'package:poll_answer/model/question.dart';
import 'package:poll_answer/quiz_list/quiz_list_controller.dart';
import 'package:poll_answer/theme/colors.dart';
import 'package:poll_answer/widgets/decoration_app_bar.dart';

class ListQuizView extends StatelessWidget {
  final QuizListConrtoller controller = Get.put(QuizListConrtoller());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizListConrtoller>(builder: (controller) {
      return Scaffold(
        backgroundColor: backgroundColor,
        appBar: toolBar(context),
        body: body(context),
      );
    });
  }

  PreferredSize toolBar(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: Size(width, 40),
      child: Container(
        height: controller.toolBarHeight,
        width: double.infinity,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: decorationAppBar(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  tr('quiz-list'),
                  style: TextStyle(
                    fontFamily: 'rubik',
                    fontSize: 18,
                    color: appBarTextColor,
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: FloatingSearchBarAction(
                showIfOpened: false,
                child: CircularButton(
                  icon: const Icon(
                    Icons.search_rounded,
                    color: iconColorWhite,
                  ),
                  onPressed: () {
                    controller.navigateToSearch();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget body(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        categoriesWidget(),
        findedQuizes(),
      ],
    );
  }

  Widget categoriesWidget() {
    return Obx(
      () => Container(
        color: transparent,
        padding: EdgeInsets.only(top: 3, bottom: 3),
        height: 42,
        child: ScrollConfiguration(
          behavior: DisableGlowBehavior(),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.savedCategories.length,
              itemBuilder: (context, index) {
                if (controller.savedCategories[index].id != -1) {
                  if (controller.selectCategorie.value ==
                      controller.savedCategories[index]) {
                    return Container(
                      padding: EdgeInsets.all(2.0),
                      child: TextButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          overlayColor:
                              MaterialStateProperty.all(overlayButtonType3),
                          backgroundColor:
                              MaterialStateProperty.all(buttonColorType3),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Text(
                          tr(controller.savedCategories[index].name),
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'rubik',
                              color: categoryTextColor),
                        ),
                        onPressed: () {},
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.all(2.0),
                      child: TextButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(buttonColorType4),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Text(
                          tr(controller.savedCategories[index].name),
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'rubik',
                              color: categoryTextColor),
                        ),
                        onPressed: () {
                          controller.changeCategory(index);
                        },
                      ),
                    );
                  }
                } else {
                  return Text("");
                }
              }),
        ),
      ),
    );
  }

  Widget findedQuizes() {
    return FadeInDown(
      child: Obx(
        () => controller.statusQuestion.value == Status.Loading
            ? Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : showListQuestion(controller.questions.value),
      ),
    );
  }

  Widget showListQuestion(List<Question> value) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: value.length,
        itemBuilder: (context, index) {
          return Container(
            child: Center(
              child: Text(value[index].description.toString()),
            ),
          );
        });
  }
}
