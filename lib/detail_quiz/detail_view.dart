// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poll_answer/core/utils/constants.dart';
import 'package:poll_answer/core/utils/scroll_mode.dart';
import 'package:poll_answer/core/utils/utils.dart';
import 'package:poll_answer/detail_quiz/detail_controller.dart';
import 'package:poll_answer/model/answer.dart';
import 'package:poll_answer/model/question.dart';
import 'package:poll_answer/theme/app_theme.dart';
import 'package:poll_answer/theme/colors.dart';
import 'package:poll_answer/widgets/button_style.dart';
import 'package:poll_answer/widgets/decoration_app_bar.dart';
import 'package:poll_answer/widgets/divider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

/***
 * Экран с вариантами ответов и статистикой в процентном соотношении для каждого варианта ответа
 * Возможность выбора только одного варианта ответа
 * 
 */
class QuizDetailView extends StatelessWidget {
  final Question _question = Get.arguments;
  final _controller = Get.put(DetailController());
  final PanelController _panel = PanelController();
  static const Size iconSize = Size(28, 28);

  @override
  Widget build(BuildContext context) {
    _controller.onSummaryVoted(_question.answerVariants);
    _controller.setQuestion(_question);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: _slidingPanel(context),
    );
  }

  Widget _slidingPanel(BuildContext context) {
    return SlidingUpPanel(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14), topRight: Radius.circular(14)),
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      minHeight: collapsedAppBarHeight,
      maxHeight: 300,
      controller: _panel,
      backdropTapClosesPanel: true,
      backdropEnabled: true,
      color: transparent,
      renderPanelSheet: false,
      // defaultPanelState: PanelState.OPEN,
      slideDirection: SlideDirection.DOWN,
      collapsed: _collapsedWidget(context),
      panel: panelWidget(),
      body: _body(context),
    );
  }

  Widget _collapsedWidget(BuildContext context) {
    return Container(
      decoration: decorationAppBar(),
      width: getScreenWidth(context),
      child: Column(
        children: [
          _appBar(),
          RotatedBox(
            quarterTurns: 3,
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: appBarIconColor3,
            ),
          )
        ],
      ),
    );
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        TextButton(
          style: buttonStyle(
            background: Colors.transparent,
            overlay: appBarButtonOverlay,
            size: iconSize,
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
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              _question.title ?? "",
              // "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890",
              style: TextStyle(
                fontFamily: 'rubik',
                fontSize: 16,
                color: appBarTextColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        TextButton(
          style: buttonStyle(
            background: Colors.transparent,
            overlay: appBarButtonOverlay,
            size: iconSize,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            Icons.info_outline_rounded,
            color: appBarIconColor,
          ),
          onPressed: () {
            _controller.navigateToInfo();
          },
        ),
      ],
    );
  }

  Widget panelWidget() {
    return Container(
      decoration: decorationAppBar(),
      padding: EdgeInsets.all(8),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  _question.title ?? "",
                  style: TextStyle(
                    fontFamily: 'rubik',
                    fontSize: 16,
                    color: appBarTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                _question.description ?? "",
                style: normalTextStyle,
                overflow: TextOverflow.fade,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: RotatedBox(
                quarterTurns: 1,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                  color: appBarIconColor3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: collapsedAppBarHeight),
      child: ScrollConfiguration(
        behavior: DisableGlowBehavior(),
        child: ListView(
            children: _question.answerVariants
                    ?.map((answer) => answer.image == null
                        ? answerTextItemWidget(answer)
                        : answerImageItemWidget(answer))
                    .toList() ??
                []),
      ),
    );
  }

  Widget answerTextItemWidget(Answer answer) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(
            top: 10,
            right: 5,
            left: 5,
          ),
          decoration: itemTextContainerDecoration(),
          child: TextButton(
            style: buttonStyle(
              borderRadius: BorderRadius.all(Radius.circular(14)),
              overlay: overlayButtonType4,
              background: Colors.transparent,
            ),
            child: Text(answer.text,
                // "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890",
                style: TextStyle(
                    fontFamily: 'rubik', color: buttonTextType1, fontSize: 15)),
            onPressed: () {
              _controller.vote(answer.id);
            },
          ),
        ),
        itemPieChart(answer),
        _divider()
      ],
    );
  }

  Widget answerImageItemWidget(Answer answer) {
    return Column(
      children: [
        FutureBuilder<Uint8List>(
          future: parseImage(answer.image),
          builder: (context, snaphot) {
            if (snaphot.hasData) {
              return Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Image.memory(
                    snaphot.requireData,
                    fit: BoxFit.cover,
                    scale: 2,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              );
            } else if (snaphot.hasError) {
              return Image.asset("assets/img/plug_image.png");
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(
            top: 10,
            right: 5,
            left: 5,
          ),
          decoration: itemTextContainerDecoration(),
          child: TextButton(
            style: buttonStyle(
              borderRadius: BorderRadius.all(Radius.circular(14)),
              overlay: overlayButtonType4,
              background: Colors.transparent,
            ),
            child: Text(answer.text,
                // "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890",
                style: TextStyle(
                    fontFamily: 'rubik', color: buttonTextType1, fontSize: 15)),
            onPressed: () {
              _controller.vote(answer.id);
            },
          ),
        ),
        itemPieChart(answer),
        _divider()
      ],
    );
  }

  Widget _divider() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: dividerFullWidth(),
    );
  }

  BoxDecoration itemTextContainerDecoration() {
    return BoxDecoration(
      color: Color(0xFF1C2A33),
      borderRadius: BorderRadius.all(Radius.circular(14)),
      boxShadow: const [
        BoxShadow(
          color: Color(0xFF19262E),
          blurRadius: 22,
          offset: Offset(-4, -4),
        ),
        BoxShadow(
          color: Color(0xFF232F36),
          blurRadius: 10,
          offset: Offset(4, 4),
        ),
      ],
    );
  }

  Container itemPieChart(Answer answer) {
    return Container(
      height: 170,
      child: PieChart(
        PieChartData(
          sectionsSpace: 0,
          centerSpaceRadius: 25,
          sections: [
            PieChartSectionData(
                title:
                    "${_controller.itemPercentVoted(answer.votedCount).round()} %",
                radius: 55,
                value: _controller.itemPercentVoted(answer.votedCount),
                color: sectionColor1,
                titleStyle: TextStyle(
                    fontSize: 16, color: textColorType2, fontFamily: 'rubik')),
            PieChartSectionData(
                title: tr('other_variants'),
                radius: 50,
                color: sectionColor2,
                value: _controller.otherPercentVoted(answer.votedCount),
                titleStyle: TextStyle(
                    fontSize: 10, color: textColorType2, fontFamily: 'rubik')),
          ],
          borderData: FlBorderData(
            show: false,
          ),
        ),
        swapAnimationDuration: Duration(milliseconds: 150), // Optional
        swapAnimationCurve: Curves.linear, // Optional
      ),
    );
  }
}
