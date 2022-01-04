// ignore_for_file: unnecessary_const, prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:poll_answer/core/utils/constants.dart';
import 'package:poll_answer/create_quiz/quiz_create_view.dart';
import 'package:poll_answer/disconnect/disconnect_view.dart';
import 'package:poll_answer/navigation/navigation_controller.dart';
import 'package:poll_answer/profile/profile_view.dart';
import 'package:poll_answer/quiz_list/quiz_list_view.dart';
import 'package:poll_answer/theme/colors.dart';

/**
 * Виджет нижней навигационной панели
 * [NavigationController] - это руторый контроллер
 * Обновление данного экрана повлечет обновление всех дочерних виджетов в [_screens]
 */

class Navigation extends StatelessWidget {
  final controller = Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(builder: (controller) {
      return Scaffold(
        extendBody: true,
        bottomNavigationBar: bottomNavBar(context),
        body: _screens[controller.screenIndex.value],
      );
    });
  }

  Widget bottomNavBar(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 55,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: const [
            BoxShadow(
                color: bottomNavBarColor,
                blurRadius: 70.0,
                spreadRadius: 5,
                offset: Offset(0.4, 4.65))
          ],
          color: bottomNavBarColor),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _itemBottomNawBar(0, tr('pool')),
            _itemBottomNawBar(1, ""),
            _itemBottomNawBar(2, tr('my_quiz')),
          ],
        ),
      ),
    );
  }

  Widget _itemBottomNawBar(int position, String title) {
    return TextButton(
      onPressed: () {
        controller.onChangeScreen(position);
      },
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(100, 50)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        overlayColor: MaterialStateProperty.all(Color(0xFF3CAF7D)),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: (position == 1 ? 2.0 : 0.0)),
            child: controller.screenIndex.value == position
                ? _iconsSelected[position]
                : _icons[position],
          ),
          title.isNotEmpty
              ? Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 12,
                    color: controller.screenIndex.value == position
                        ? itemNavBarTitleSelectedColor
                        : itemNavBarColor,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  final _icons = [
    Image.asset(
      'assets/img/ic_task.png',
      width: iconNavSize,
      height: iconNavSize,
    ),
    Image.asset(
      'assets/img/ic_add_quiz.png',
      width: iconNavSize + 10,
      height: iconNavSize + 10,
    ),
    Image.asset(
      'assets/img/ic_profile.png',
      width: iconNavSize,
      height: iconNavSize,
    )
  ];
  final _iconsSelected = [
    Image.asset(
      'assets/img/ic_task_selected.png',
      width: iconNavSize,
      height: iconNavSize,
    ),
    Image.asset(
      'assets/img/ic_add_quiz_selected.png',
      width: iconNavSize + 10,
      height: iconNavSize + 10,
    ),
    Image.asset(
      'assets/img/ic_profile_selected.png',
      width: iconNavSize,
      height: iconNavSize,
    )
  ];

  final _screens = [ListQuizView(), QuizCreateView(), ProfileView()];
}
