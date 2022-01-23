// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:typed_data';

import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:poll_answer/api/api_response.dart';
import 'package:poll_answer/core/utils/constants.dart';
import 'package:poll_answer/core/utils/scroll_mode.dart';
import 'package:poll_answer/core/utils/utils.dart';
import 'package:poll_answer/model/answer.dart';
import 'package:poll_answer/model/question.dart';
import 'package:poll_answer/quiz_list/quiz_list_controller.dart';
import 'package:poll_answer/theme/app_theme.dart';
import 'package:poll_answer/theme/colors.dart';
import 'package:poll_answer/widgets/decoration_app_bar.dart';
import 'package:poll_answer/widgets/divider.dart';

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
    return RefreshIndicator(
      onRefresh: controller.onRefreshQuestion,
      child: Stack(
        children: [
          categoriesWidget(),
          bodyQuestions(),
        ],
      ),
    );
  }

  Widget categoriesWidget() {
    return Obx(
      () => Container(
        alignment: Alignment.topCenter,
        color: transparent,
        padding: EdgeInsets.only(top: 3, bottom: 3),
        height: categoryHeight,
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
                            color: categoryTextColor,
                          ),
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

  Widget bodyQuestions() {
    return FadeInDown(
      child: Obx(
        () => checkQuestionsStatus(controller.statusQuestion.value),
      ),
    );
  }

  Widget checkQuestionsStatus(Status status) {
    switch (status) {
      case Status.Loading:
        return loadingWidget();
      case Status.Empty:
        return emptyWidget();
      case Status.Success:
        return questionsWidget(controller.questions);
      default:
        return errorWidget();
    }
  }

  Widget emptyWidget() {
    return Container(
      height: double.infinity,
      margin: marginMainContainer,
      child: Center(
        child: Text(
          tr('empty-category'),
          textAlign: TextAlign.center,
          style: messageTextStyle,
        ),
      ),
    );
  }

  Widget errorWidget() {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Image.asset(
              'assets/img/no_connect.png',
              width: 200,
              height: 200,
              color: iconColorType2,
              alignment: Alignment.topCenter,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
            child: Text(
              tr('error_request'),
              style: messageTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget questionsWidget(List<Question> questions) {
    return Container(
      margin: marginMainContainer,
      child: PageView.builder(
        scrollBehavior: DisableGlowBehavior(),
        itemCount: questions.length,
        scrollDirection: Axis.vertical,
        controller: controller.pageController,
        itemBuilder: (context, position) {
          return Container(
            margin: EdgeInsets.only(top: 4, left: 6, right: 6, bottom: 10),
            decoration: BoxDecoration(
              color: startColorAppBar,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                  child: Text(
                    questions[position].title.toString(),
                    textAlign: TextAlign.center,
                    style: titleTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 8.0),
                  child: divider(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4),
                  child: Text(
                    questions[position].description.toString(),
                    textAlign: TextAlign.justify,
                    style: normalTextStyle,
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 1.0,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    enableInfiniteScroll: false,
                    initialPage: 0,
                    autoPlay: false,
                  ),
                  items: variantsWidget(questions[position].answerVariants),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget>? variantsWidget(List<Answer>? variants) {
    return variants
        ?.map((item) => Container(
              child: item.image == null
                  ? Container()
                  : ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        children: <Widget>[
                          FutureBuilder<Uint8List>(
                              future: parseImage(item.image),
                              builder: (context, snaphot) {
                                if (snaphot.hasData) {
                                  return Image.memory(
                                    snaphot.requireData,
                                    fit: BoxFit.cover,
                                    height: 300,
                                    width: 1000,
                                  );
                                } else if (snaphot.hasError) {
                                  return Image.asset("plug_image.png");
                                } else {
                                  return CircularProgressIndicator();
                                }
                              }),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(200, 0, 0, 0),
                                    Color.fromARGB(0, 0, 0, 0)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: Text(
                                item.text,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
            ))
        .toList();
  }

  Widget loadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  final EdgeInsets marginMainContainer =
      EdgeInsets.only(top: categoryHeight, bottom: bottomNavBarHeight);
}
