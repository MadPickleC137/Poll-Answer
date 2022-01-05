// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:poll_answer/core/utils/scroll_mode.dart';
import 'package:poll_answer/quiz_list/quiz_list_controller.dart';
import 'package:poll_answer/theme/colors.dart';
import 'package:poll_answer/widgets/decoration_app_bar.dart';

class ListQuizView extends StatelessWidget {
  final QuizListConrtoller controller = Get.put(QuizListConrtoller());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizListConrtoller>(builder: (controller) {
      return Scaffold(
        appBar: toolBar(context),
        body: body(context),
      );
    });
  }

  PreferredSize toolBar(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: Size(width, 50),
      child: Container(
        height: controller.toolBarHeight.value,
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
    //категории
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        categoriesWidget(),
        Obx(() => findedQuizes(controller.selectCategorie.value))
      ],
    );
  }

  Widget categoriesWidget() {
    return Container(
      color: transparent,
      height: 40,
      child: ScrollConfiguration(
        behavior: DisableGlowBehavior(),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              if (controller.selectCategorie.value ==
                  controller.categories[index]) {
                return Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        padding: EdgeInsets.all(14),
                        margin: EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            gradient: LinearGradient(colors: [
                              categoryBackgroundStartColor,
                              categoryBackgroundEndColor,
                            ])),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                      ),
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          controller.categories[index],
                          style: TextStyle(
                              fontFamily: 'rubik', color: categoryTextColor),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          padding: EdgeInsets.all(14),
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: transparent,
                              border: Border.all(
                                width: 2,
                                color: categoryBackgroundEndColor,
                              )),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: rippleEffectColor,
                        ),
                        onPressed: () {
                          controller.changeCategory(index);
                        },
                        child: Center(
                          child: Text(
                            controller.categories[index],
                            style: TextStyle(
                                fontFamily: 'rubik', color: categoryTextColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }

  Widget findedQuizes(String value) {
    return FadeInDown(
      child: Container(
        child: Center(
          child: Text(
            value,
          ),
        ),
      ),
    );
  }
}
