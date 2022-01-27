import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:poll_answer/core/utils/scroll_mode.dart';
import 'package:poll_answer/core/utils/utils.dart';
import 'package:poll_answer/detail_quiz/detail_controller.dart';
import 'package:poll_answer/model/answer.dart';
import 'package:poll_answer/model/question.dart';
import 'package:poll_answer/theme/app_theme.dart';
import 'package:poll_answer/theme/colors.dart';
import 'package:poll_answer/widgets/button_style.dart';
import 'package:poll_answer/widgets/decoration_app_bar.dart';

class QuizDetailView extends StatelessWidget {
  final Question _question = Get.arguments;
  final _controller = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [_appBar(context), _body(context)],
      ),
    );
  }

  _appBar(BuildContext context) {
    return Container(
      width: getScreenWidth(context),
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: decorationAppBar(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  _controller.navigateToBack();
                },
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _question.title ?? "",
                    // "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890",
                    style: TextStyle(
                      fontFamily: 'rubik',
                      fontSize: 16,
                      color: appBarTextColor,
                    ),
                    overflow: TextOverflow.visible,
                    maxLines: 10,
                  ),
                ),
              ),
              TextButton(
                style: buttonStyle(
                  background: Colors.transparent,
                  overlay: appBarButtonOverlay,
                  size: Size(35, 35),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.info_outline_rounded,
                  color: appBarIconColor,
                ),
                onPressed: () {},
              ),
            ],
          ),
          descriptionWidget(),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return ScrollConfiguration(
      behavior: DisableGlowBehavior(),
      child: Container(),

      //  ListView(
      //     children: _question.answerVariants
      //             ?.map((answer) => answer.image == null
      //                 ? answerTextItemWidget(answer)
      //                 : answerImageItemWidget(answer))
      //             .toList() ??
      //         []),
    );
  }

  Widget descriptionWidget() {
    return GestureDetector(
      onTap: () {
        _controller.collapsed.value = !_controller.collapsed.value;
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Obx(
          () => Text(
            // _question.description ?? "",
            "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890",
            style: normalTextStyle,
            overflow: _controller.collapsed.value
                ? TextOverflow.ellipsis
                : TextOverflow.fade,
          ),
        ),
      ),
    );
  }

  Widget answerTextItemWidget(Answer answer) {
    return Container();
  }

  Widget answerImageItemWidget(Answer answer) {
    return Container(
      padding: EdgeInsets.only(top: 10, right: 5, left: 5, bottom: 10),
      child: Column(
        children: [
          FutureBuilder<Uint8List>(
              future: parseImage(answer.image),
              builder: (context, snaphot) {
                if (snaphot.hasData) {
                  return Container(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Image.memory(
                        snaphot.requireData,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  );
                } else if (snaphot.hasError) {
                  return Image.asset("assets/img/plug_image.png");
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ],
      ),
    );
  }
}
