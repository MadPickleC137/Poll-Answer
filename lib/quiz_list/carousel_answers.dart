// ignore_for_file: avoid_unnecessary_containers

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poll_answer/core/utils/scroll_mode.dart';
import 'package:poll_answer/core/utils/utils.dart';
import 'package:poll_answer/model/answer.dart';
import 'package:poll_answer/quiz_list/carousel_indicator.dart';
import 'package:poll_answer/theme/app_theme.dart';
import 'package:poll_answer/theme/colors.dart';

class CarouselAnswers extends StatelessWidget {
  RxInt _index = 0.obs;

  CarouselAnswers(this._answers);
  List<Answer> _answers = [];
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: darkBackground,
          margin: const EdgeInsets.only(top: 4),
          child: PageView(
            scrollBehavior: DisableGlowBehavior(),
            scrollDirection: Axis.horizontal,
            onPageChanged: (index) {
              _index.value = index;
            },
            children: _items(),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Obx(() => CarouselIndicator(
              count: _answers.length, selected: _index.value)),
        )
      ],
    );
  }

  List<Widget> _items() {
    return _answers
        .map((answer) => answer.image == null
            ? textVariantWidget(answer)
            : imageVariantWidget(answer))
        .toList();
  }

  Widget textVariantWidget(Answer item) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 30),
      decoration: BoxDecoration(
        color: darkBackground3,
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Text(
          item.text,
          style: normalTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget imageVariantWidget(Answer item) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        FutureBuilder<Uint8List>(
            future: parseImage(item.image),
            builder: (context, snaphot) {
              if (snaphot.hasData) {
                return Container(
                  height: 200,
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
        Container(
          width: double.infinity,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: darkBackground3,
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          padding: const EdgeInsets.all(10.0),
          child: Text(
            item.text,
            style: normalTextStyle,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }
}
