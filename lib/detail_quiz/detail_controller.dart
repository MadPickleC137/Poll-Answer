import 'dart:math';

import 'package:get/get.dart';
import 'package:poll_answer/api/api_response.dart';
import 'package:poll_answer/api/api_rest.dart';
import 'package:poll_answer/model/answer.dart';
import 'package:poll_answer/model/question.dart';
import 'package:poll_answer/navigation/routes.dart';

class DetailController extends GetxController {
  int allVotedCount = 0;
  Question? question;
  Rx<Status> statusVoted = Status.Empty.obs;
  @override
  void onReady() {}

  RxBool collapsed = true.obs;
  void navigateToBack() {
    Get.back();
  }

  void onSummaryVoted(List<Answer>? answerVariants) {
    answerVariants?.forEach((element) {
      element.votedCount = Random().nextInt(1000);
      allVotedCount += element.votedCount;
    });
  }

  double itemPercentVoted(int votedCount) {
    return (votedCount / allVotedCount) * 100;
  }

  double otherPercentVoted(int votedCount) {
    return ((allVotedCount - votedCount) / allVotedCount) * 100;
  }

  void setQuestion(Question question) {
    this.question = question;
  }

  Future<void> vote(int id) async {
    if (question == null) statusVoted.value = Status.Error;
    var response = await RestApi.voteByQuestion(question?.id ?? 0, id);
    statusVoted.value = response.status;
  }

  void navigateToInfo() {
    Get.toNamed(Routes.INFO);
  }
}
