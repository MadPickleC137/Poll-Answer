import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:poll_answer/core/utils/constants.dart';
import 'package:poll_answer/theme/app_theme.dart';
import 'package:poll_answer/theme/colors.dart';
import 'package:poll_answer/widgets/button_style.dart';

class DialogActionParams {
  String text = "";
  Function? action;
  LinearGradient gradient = buttonGradientType1;
  String imagePath = "";
  Color overlayColor = overlayButtonType1;
  DialogActionParams({
    required this.text,
    this.action,
    required this.gradient,
    required this.overlayColor,
    required this.imagePath,
  });
}

void dialogAction(String message, List<DialogActionParams> actionsParams) {
  Get.defaultDialog(
    title: tr('action'),
    titleStyle: titleTextStyle,
    backgroundColor: transparent,
    content: Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        color: backgroundColor,
      ),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: _listActions(actionsParams),
      ),
    ),
  );
}

List<Widget> _listActions(List<DialogActionParams> actionsParams) {
  return actionsParams
      .map(
        (param) => Container(
          height: buttonHeight,
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            gradient: param.gradient,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: buttonShadowType2,
          ),
          child: TextButton(
            style: buttonStyle(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              overlay: param.overlayColor,
              background: Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(param.text,
                      style: const TextStyle(
                          fontFamily: 'rubik',
                          color: buttonTextType1,
                          fontSize: 14)),
                ),
                Image.asset(
                  param.imagePath,
                  width: 30,
                  height: 28,
                ),
              ],
            ),
            onPressed: () {},
          ),
        ),
      )
      .toList();
}
