import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:poll_answer/api/api_response.dart';
import 'package:poll_answer/api/api_rest.dart';
import 'package:poll_answer/model/answer.dart';
import 'package:poll_answer/model/question.dart';
import 'package:poll_answer/navigation/routes.dart';
import 'package:poll_answer/theme/colors.dart';
import 'package:poll_answer/widgets/snackbar.dart';

class DetailController extends GetxController {
  int allVotedCount = 0;
  Question? question;
  Rx<Status> statusVoted = Status.Empty.obs;
  bool isShowedSnackBar = false;
  @override
  void onReady() {}

  RxBool collapsed = true.obs;
  void navigateToBack() {
    Get.back();
  }

  void onSummaryVoted(List<Answer>? answerVariants) {
    answerVariants?.forEach((element) {
      // element.votedCount = Random().nextInt(1000);
      allVotedCount += element.votedCount;
    });
  }

  double itemPercentVoted(int votedCount) {
    if (allVotedCount > 0 && votedCount > 0) {
      return (votedCount / allVotedCount) * 100;
    }
    return 0.0;
  }

  double otherPercentVoted(int votedCount) {
    if (allVotedCount > 0 && votedCount > 0) {
      return ((allVotedCount - votedCount) / allVotedCount) * 100;
    }
    return 0.0;
  }

  void setQuestion(Question question) {
    this.question = question;
  }

  Future<void> vote(int id) async {
    if (question == null) statusVoted.value = Status.Error;
    var response = await RestApi.voteByQuestion(question?.id ?? 0, id);
    statusVoted.value = response.status;
    _showSnackbar(statusVoted.value);
  }

  void navigateToInfo() {
    Get.toNamed(Routes.INFO);
  }

  void _showSnackbar(Status status) {
    if (isShowedSnackBar) return;
    if (status == Status.Success) {
      showSnackbar(
        tr('success_title'),
        "assets/img/ic_ok.png",
        iconColorType2,
        false,
      );
    } else if (status == Status.Error) {
      showSnackbar(
        tr('error_request'),
        "assets/img/ic_err.png",
        iconColorType3,
        true,
      );
    } else {
      showSnackbar(
        tr('double_vote_error'),
        "assets/img/ic_err.png",
        iconColorType3,
        true,
      );
    }

    isShowedSnackBar = true;
  }
}
