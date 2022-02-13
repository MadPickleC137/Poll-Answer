// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poll_answer/create_quiz/quiz_create_controller.dart';
import 'package:poll_answer/model/answer.dart';
import 'package:poll_answer/model/category.dart';
import 'package:poll_answer/theme/app_theme.dart';
import 'package:poll_answer/theme/colors.dart';
import 'package:poll_answer/widgets/button_style.dart';
import 'package:poll_answer/widgets/decoration_app_bar.dart';
import 'package:poll_answer/widgets/divider.dart';
import 'package:poll_answer/widgets/edit_text_decoration.dart';

class QuizCreateView extends StatelessWidget {
  final controller = Get.put(CreateController());
  @override
  Widget build(BuildContext context) {
    controller.getCategories();
    return Scaffold(
      appBar: toolBar(context),
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      body: bodyWidget(context),
    );
  }

  Widget bodyWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            backgroundColor,
            backgroundColor,
          ],
        ),
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: body(context),
          ),
          addQuestionButton(),
        ],
      ),
    );
  }

  Align addQuestionButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          gradient: buttonGradientType1,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: buttonShadowType1,
        ),
        child: TextButton(
          style: buttonStyle(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            overlay: overlayButtonType1,
            background: Colors.transparent,
            size: Size(100, 36),
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
                        color: buttonTextType1,
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
            controller.createQuestion();
          },
        ),
      ),
    );
  }

  PreferredSize toolBar(BuildContext context) {
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
            dropdownColor: darkBackground,
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
            controller: controller.titleTextController,
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
          controller: controller.descTextController,
          decoration: textDecor(tr('description'), null),
          onChanged: (val) {},
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 10, left: 32, right: 32),
        padding: EdgeInsets.all(4),
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: buttonGradientType1,
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
            boxShadow: buttonShadowType1),
        child: Center(
          child: Text(
            tr('variants'),
            style: TextStyle(
                fontFamily: 'rubik', color: Color(0xFF1A5F9D), fontSize: 12),
          ),
        ),
      ),
      Obx(() => variantsAddWidget(controller.variants.value)),
      Obx(
        () => controller.variants.length < 5
            ? addAnswerButton()
            : Container(height: 45),
      )
    ]);
  }

  Container addAnswerButton() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 50),
      child: TextButton.icon(
        onPressed: () {
          controller.addNewVariant();
        },
        icon: Icon(
          Icons.add_circle_outline_rounded,
          color: iconColorType2,
          size: 35,
        ),
        label: Text(tr('add-variant'),
            style: TextStyle(
                fontFamily: 'rubik', color: textColorType2, fontSize: 15)),
      ),
    );
  }

  Widget variantsAddWidget(List<Answer> values) {
    return Container(
      padding: EdgeInsets.only(top: 12),
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          darkBackground2,
          darkBackground2,
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
                      margin: EdgeInsets.only(top: 10, left: 12, right: 45),
                      height: 36,
                      child: TextFormField(
                        controller: controller.editTextControllers[index],
                        cursorHeight: 20,
                        maxLength: 50,
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
                        style: buttonStyle(
                          overlay: overlayButtonType2,
                          background: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          size: Size(35, 35),
                        ),
                        child: Icon(
                          Icons.delete_outline_rounded,
                          color: iconColorType2,
                        ),
                        onPressed: () {
                          controller.deleteItemVariant(index);
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 6),
                  child: TextButton(
                    style: buttonStyle(
                      overlay: overlayButtonType4,
                      background: buttonColorType4,
                      borderRadius: BorderRadius.circular(10),
                      size: Size(80, 80),
                    ),
                    child: Obx(
                      () => controller.variants[index].image != null
                          ? Container(
                              padding: EdgeInsets.zero,
                              width: 180,
                              height: 180,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: controller
                                        .variants[index].image!.isNotEmpty
                                    ? Image.file(
                                        File(controller.variants[index].image!),
                                        fit: BoxFit.cover,
                                      )
                                    : Icon(
                                        Icons.add_photo_alternate_rounded,
                                        color: iconColorWhite,
                                        size: 35,
                                      ),
                              ),
                            )
                          : Icon(
                              Icons.add_photo_alternate_rounded,
                              color: iconColorWhite,
                              size: 35,
                            ),
                    ),
                    onPressed: () {
                      addPhotoVariant(context, index);
                    },
                  ),
                ),
                divider()
              ],
            );
          }),
    );
  }

  void addPhotoVariant(BuildContext context, int index) {
    Get.bottomSheet(
      Container(
        height: 140,
        color: darkBackground,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  Get.back();
                  controller.pickPhoto(ImageSource.gallery, index);
                },
                icon: Icon(
                  Icons.photo_library_rounded,
                  color: iconColorType2,
                  size: 35,
                ),
                label: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  width: double.infinity,
                  child: Text(tr('from-galery'),
                      style: TextStyle(
                          fontFamily: 'rubik',
                          color: textColorType2,
                          fontSize: 15)),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Get.back();
                  controller.pickPhoto(ImageSource.camera, index);
                },
                icon: Icon(
                  Icons.camera_alt_rounded,
                  color: iconColorType2,
                  size: 35,
                ),
                label: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  width: double.infinity,
                  child: Text(tr('from-camera'),
                      style: TextStyle(
                          fontFamily: 'rubik',
                          color: textColorType2,
                          fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

var textStyle14 =
    TextStyle(fontFamily: 'rubik', color: textColorType3, fontSize: 14);

var textStyle15 =
    TextStyle(fontFamily: 'rubik', color: textColorType3, fontSize: 15);
