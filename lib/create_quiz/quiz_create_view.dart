// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:poll_answer/create_quiz/quiz_create_controller.dart';
import 'package:poll_answer/model/answer.dart';
import 'package:poll_answer/model/category.dart';
import 'package:poll_answer/theme/colors.dart';
import 'package:poll_answer/widgets/decoration_app_bar.dart';
import 'package:poll_answer/widgets/edit_text_decoration.dart';

class QuizCreateView extends StatelessWidget {
  final controller = Get.put(CreateController());
  @override
  Widget build(BuildContext context) {
    // controller.getCategories();
    return Scaffold(
      appBar: toolBar(context),
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFF2A3740),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2A3740),
              Color(0xFF2A3740),
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
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xE18CB5E4),
                      Color(0xD7BFE5FF),
                      Color(0xCCB5E1FF),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x881FA4FF),
                      offset: Offset(2, 2),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Color(0xFF1FA4FF),
                      offset: Offset(-4, -4),
                      blurRadius: 16,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: TextButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(100, 36)),
                    overlayColor: MaterialStateProperty.all(Color(0xFF1FA4FF)),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
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
                color: Color(0xFFBFE5FF),
              ),
              onPressed: () {
                controller.navigateToBack();
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
                    color: Color(0xFFBFE5FF),
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
      GetBuilder<CreateController>(
        builder: (_controller) => Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12, top: 12),
          child: DropdownButtonFormField(
            hint: Text(
              tr('category'),
              style: TextStyle(color: categoryTextColor),
            ),
            dropdownColor: Color(0x33192229),
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
                  style: textStyle14,
                ),
                value: category,
              );
            }).toList(),
          ),
        ),
      ),
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
            style: textStyle15,
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
          style: textStyle15,
          decoration: textDecor(tr('description'), null),
          onChanged: (val) {},
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 10, left: 32, right: 32),
        padding: EdgeInsets.all(4),
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF8CB5E4),
                Color(0xFFBFE5FF),
                Color(0xFFB5E1FF),
              ],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x881FA4FF),
                offset: Offset(2, 2),
                blurRadius: 15,
                spreadRadius: 1,
              ),
              BoxShadow(
                color: Color(0xFF1FA4FF),
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
      Obx(() => variantsAddWidget(controller.variants.value)),
      GetBuilder<CreateController>(
        builder: (_controller) => _controller.variants.length < 5
            ? Container(
                margin: EdgeInsets.only(top: 10, bottom: 50),
                child: TextButton.icon(
                  onPressed: () {
                    _controller.addNewVariant();
                  },
                  icon: Icon(
                    Icons.add_circle_outline_rounded,
                    color: Color(0xFF8CB5E4),
                    size: 35,
                  ),
                  label: Text(tr('add-variant'),
                      style: TextStyle(
                          fontFamily: 'rubik',
                          color: Color(0xFFBFE5FF),
                          fontSize: 15)),
                ),
              )
            : Container(
                height: 45,
              ),
      )
    ]);
  }

  void addPhotoVariant() {}

  void addNewQuestion() {}

  Widget variantsAddWidget(List<Answer> values) {
    var index = 0;
    return Container(
      padding: EdgeInsets.only(left: 12, top: 12),
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color(0x33192229),
          Color(0x33192229),
        ],
      )),
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: values.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, right: 45),
                      height: 36,
                      child: TextFormField(
                        controller:
                            controller.editTextVariants[values[index].id],
                        cursorHeight: 20,
                        maxLength: 100,
                        maxLines: 1,
                        minLines: 1,
                        textAlign: TextAlign.left,
                        style: textStyle14,
                        decoration: textDecor(tr('prompt-variant'), null),
                        onChanged: (val) {},
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(35, 35)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          overlayColor:
                              MaterialStateProperty.all(Color(0xC7B9906E)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Icon(
                          Icons.delete_outline_rounded,
                          color: Color(0xFFBFE5FF),
                        ),
                        onPressed: () {
                          controller.deleteItemVariant(values[index].id);
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 6),
                  child: TextButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(80, 80)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      overlayColor: MaterialStateProperty.all(
                        Color(0xC7B5E1FF),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xDE8CB5E4),
                      ),
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
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: double.infinity,
                  height: 0.5,
                  color: Color(0xC7B5E1FF),
                )
              ],
            );
          }),
    );
  }
}

var textStyle14 =
    TextStyle(fontFamily: 'rubik', color: Color(0xFFBFCEDB), fontSize: 14);

var textStyle15 =
    TextStyle(fontFamily: 'rubik', color: Color(0xFFBFCEDB), fontSize: 15);
