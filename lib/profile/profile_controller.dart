import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:poll_answer/api/api_response.dart';
import 'package:poll_answer/model/question.dart';
import 'package:poll_answer/navigation/routes.dart';

class ProfileController extends GetxController {
  int groupValue = 0;
  List<Question> questions = List.empty();
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

  /**
   * после создания опроса его нужно добавить в кэш
   */
  Future<void> getUserQuestions() async {
    var cache = Hive.box('user-questions');
    questions = cache.get('list') ?? RxList.empty();
    if (questions.isEmpty) {
      statusQuestionLoad = Status.Empty;
    } else {
      statusQuestionLoad = Status.Success;
    }
    update();
  }

  void navigateToError() {
    Get.toNamed(Routes.DISCONNECT);
  }
}
