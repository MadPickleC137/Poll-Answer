import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:poll_answer/model/question.dart';
import 'package:poll_answer/theme/app_theme.dart';
import 'package:poll_answer/theme/colors.dart';
import 'package:poll_answer/widgets/app_bar.dart';
import 'package:poll_answer/widgets/divider.dart';

class QuizStatisticView extends StatelessWidget {
  final Question _question = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBarBackButton(tr('title_stat'), context, _back),
      body: SingleChildScrollView(
        child: _body(context),
      ),
    );
  }

  void _back() {
    Get.back();
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              _question.title.toString(),
              textAlign: TextAlign.center,
              style: quizTitleTextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                _question.description.toString(),
                textAlign: TextAlign.justify,
                style: normalTextStyle,
              ),
            ),
          ),
          dividerText(tr('count_voted')),
          itemPieChart(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: _variants(),
          )
        ],
      ),
    );
  }

  Widget itemPieChart() {
    colorIndex = 0;
    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sectionsSpace: 0,
          centerSpaceRadius: 25,
          sections: _question.answerVariants
              ?.map((answer) => PieChartSectionData(
                  title: "${_getPercentItem(answer.votedCount).round()} %",
                  radius: 55,
                  value: _getPercentItem(answer.votedCount),
                  color: _getSectionColor(),
                  titleStyle: const TextStyle(
                      fontSize: 16,
                      color: textColorType2,
                      fontFamily: 'rubik')))
              .toList(),
          borderData: FlBorderData(
            show: false,
          ),
        ),
        swapAnimationDuration: const Duration(milliseconds: 250), // Optional
        swapAnimationCurve: Curves.linear, // Optional
      ),
    );
  }

  double _getPercentItem(int votedCount) {
    double allVoted = 0.0001;

    _question.answerVariants?.forEach((element) {
      allVoted = allVoted + element.votedCount;
    });
    return (votedCount / allVoted) * 100;
  }

  int colorIndex = 0;

  Color _getSectionColor() {
    return sectionColors[colorIndex++];
  }

  Widget _variants() {
    colorIndex = 0;
    return Column(
      children: _question.answerVariants
              ?.map((variant) => Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            color: _getSectionColor(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            variant.votedCount.toString(),
                            textAlign: TextAlign.justify,
                            style: normalTextStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            variant.text.toString(),
                            textAlign: TextAlign.justify,
                            style: normalTextStyle,
                          ),
                        )
                      ],
                    ),
                  ))
              .toList() ??
          [],
    );
  }
}
