// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:poll_answer/core/utils/scroll_mode.dart';
import 'package:poll_answer/create_quiz/quiz_create_controller.dart';
import 'package:poll_answer/model/answer.dart';
import 'package:poll_answer/model/category.dart';
import 'package:poll_answer/theme/colors.dart';
import 'package:poll_answer/widgets/decoration_app_bar.dart';
import 'package:poll_answer/widgets/edit_text_decoration.dart';

class QuizCreateView extends StatelessWidget {
  final _controller = Get.put(CreateController());
  final scroller = ScrollController();
  @override
  Widget build(BuildContext context) {
    _controller.getCategories();
    return Scaffold(
      appBar: toolBar(context),
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFBC0FCE9),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xD8C9EBE0),
              gradientEndType2,
            ],
          ),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: body(context),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(100, 36)),
                  overlayColor: MaterialStateProperty.all(Color(0x6B7E78D3)),
                  backgroundColor: MaterialStateProperty.all(Color(0xFF1A5F9D)),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: Text(tr('add-quiz'),
                          style: TextStyle(
                              fontFamily: 'rubik',
                              color: Color(0xFFF8FCFF),
                              fontSize: 15)),
                    ),
                    Spacer(),
                    Image.asset(
                      'assets/img/ic_edit.png',
                      width: 35,
                      height: 32,
                    ),
                  ],
                ),
                onPressed: () {
                  addNewQuestion();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSize toolBar(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: Size(width, 40),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: decorationAppBar(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            TextButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(35, 35)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                overlayColor: MaterialStateProperty.all(Color(0x6BBCD8BB)),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                shadowColor: MaterialStateProperty.all(Colors.transparent),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: iconColorWhite,
              ),
              onPressed: () {
                _controller.navigateToBack();
              },
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  tr('create-quiz'),
                  style: TextStyle(
                    fontFamily: 'rubik',
                    fontSize: 18,
                    color: appBarTextColor,
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

  Widget body(BuildContext context) {
    return Column(children: [
      Obx(() => Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12, top: 12),
            child: DropdownButtonFormField(
              hint: Text(
                tr('category'),
                style: TextStyle(color: categoryTextColor),
              ),
              dropdownColor: Color(0xFF43CEA2),
              menuMaxHeight: 450,
              icon: Icon(Icons.arrow_drop_down_circle),
              decoration: textDecor(tr('category'), Icons.category_rounded),
              onChanged: (newValue) {
                _controller.setSelectedCategory(newValue as Category);
              },
              value: _controller.selectedCat.value,
              items: _controller.savedCategories.map((category) {
                return DropdownMenuItem(
                  child: Text(
                    tr(category.name),
                    style: TextStyle(
                        fontFamily: 'rubik',
                        color: Color(0xFF1A5F9D),
                        fontSize: 15),
                  ),
                  value: category,
                );
              }).toList(),
            ),
          )),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Container(
          height: 36,
          child: TextFormField(
            cursorHeight: 20,
            autocorrect: false,
            maxLength: 30,
            textAlign: TextAlign.left,
            maxLines: 1,
            minLines: 1,
            style: TextStyle(
                fontFamily: 'rubik', color: Color(0xFF1A5F9D), fontSize: 15),
            decoration: textDecor(tr('title'), Icons.title_rounded),
            onChanged: (val) {},
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        child: TextFormField(
          cursorHeight: 20,
          autocorrect: false,
          maxLength: 500,
          maxLines: 10,
          minLines: 1,
          textAlign: TextAlign.left,
          keyboardType: TextInputType.multiline,
          style: TextStyle(
              fontFamily: 'rubik', color: Color(0xFF1A5F9D), fontSize: 14),
          decoration: textDecor(tr('description'), null),
          onChanged: (val) {},
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 10, left: 32, right: 32),
        padding: EdgeInsets.all(4),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xFFC2C7F6),
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFDDC2F6),
                offset: Offset(4, 4),
                blurRadius: 16,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Color(0xFFE5D5F3),
                offset: Offset(-4, -4),
                blurRadius: 16,
                spreadRadius: 1,
              ),
            ]),
        child: Center(
          child: Text(
            tr('variants'),
            style: TextStyle(
                fontFamily: 'rubik', color: Color(0xFF1A5F9D), fontSize: 12),
          ),
        ),
      ),
      Obx(
        () => variantsAddWidget(_controller.variants.value),
      ),
      Container(
        margin: EdgeInsets.only(top: 10, bottom: 50),
        child: TextButton.icon(
          onPressed: () {
            addNewVariant();
          },
          icon: Icon(
            Icons.add_circle_outline_rounded,
            color: iconColorWhite,
            size: 35,
          ),
          label: Text(tr('add-variant'),
              style: TextStyle(
                  fontFamily: 'rubik', color: Color(0xFF1A5F9D), fontSize: 15)),
        ),
      ),
    ]);
  }

  void addNewVariant() {
    _controller.variants.add(Answer(id: -1, votedCount: 0, text: ""));
  }

  void addPhotoVariant() {}

  void addNewQuestion() {}

  Widget variantsAddWidget(List<Answer> value) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(color: Colors.black54),
      child: Column(
        children: value
            .map<Widget>(
              (answer) => Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 36,
                    child: TextFormField(
                      cursorHeight: 20,
                      maxLines: 1,
                      minLines: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'rubik',
                          color: Color(0xFF1A5F9D),
                          fontSize: 14),
                      decoration: textDecor(
                          tr('prompt-variant'), Icons.question_answer_outlined),
                      onChanged: (val) {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: TextButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(100, 100)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        overlayColor:
                            MaterialStateProperty.all(Color(0x6B8FC58E)),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xD8AADDCD)),
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Icon(
                        Icons.add_photo_alternate_rounded,
                        color: iconColorWhite,
                        size: 35,
                      ),
                      onPressed: () {
                        addPhotoVariant();
                      },
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
