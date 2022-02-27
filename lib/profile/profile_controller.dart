import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poll_answer/api/api_response.dart';
import 'package:poll_answer/api/api_rest.dart';
import 'package:poll_answer/model/question.dart';
import 'package:poll_answer/navigation/routes.dart';
import 'package:poll_answer/theme/colors.dart';
import 'package:poll_answer/widgets/dialog_action.dart';

class ProfileController extends GetxController {
  int groupValue = 0;
  List<Question> questions = [];
  var statusQuestionLoad = Status.Loading;

  void onChangeSegment(int? value) {
    if (value != null) {
      groupValue = value;
      update();
    }
  }

  @override
  void onReady() {
    super.onReady();
    getUserQuestions();
  }

  void navigateToInfo() {
    Get.toNamed(Routes.INFO);
  }

  List<Question> getActiveQuests() {
    return questions.where((item) => item.isPollCompleted == false).toList();
  }

  List<Question> getClosedQuests() {
    return questions.where((item) => item.isPollCompleted == true).toList();
  }

  Future<void> getUserQuestions() async {
    var response = await RestApi.getUserQuestions();
    if (response.data.isEmpty) {
      response.status = Status.Empty;
    } else {
      questions = response.data;
    }
    statusQuestionLoad = response.status;
    update();
  }

  void navigateToError() {
    Get.toNamed(Routes.DISCONNECT);
  }

  void showActionDialog(Question question) {
    dialogAction("Success", [
      DialogActionParams(
        text: tr('show_stat'),
        gradient: buttonGradientType2,
        imagePath: "assets/img/ic_stat.png",
        overlayColor: overlayButtonType5,
        action: () {
          Get.toNamed(Routes.QUIZ_STATISTIC, arguments: question);
        },
      ),
      DialogActionParams(
        text: tr('close_quiz'),
        gradient: buttonGradientType2,
        imagePath: "assets/img/ic_edit.png",
        overlayColor: overlayButtonType5,
        action: () {
          Get.toNamed(Routes.QUIZ_STATISTIC, arguments: question);
        },
      ),
    ]);
  }
}
