import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:poll_answer/api/api_response.dart';
import 'package:poll_answer/api/api_rest.dart';
import 'package:poll_answer/core/utils/constants.dart';
import 'package:poll_answer/core/utils/utils.dart';
import 'package:poll_answer/model/category.dart';
import 'package:poll_answer/model/question.dart';
import 'package:poll_answer/navigation/routes.dart';

class QuizListConrtoller extends GetxController {
  RxBool isSearch = false.obs;
  Rx<Category> selectCategorie = Category(id: -1, name: 'All').obs;
  double toolBarHeight = 50.0;
  RxList<Category> savedCategories = RxList.empty();
  List<Question> questions = [];
  Rx<Status> statusQuestion = Status.Loading.obs;
  PageController pageController = PageController();
  double answerHeight = 0.0;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getCategories();
    getDefaultQuestion();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void navigateToSearch() {
    Get.toNamed(Routes.QUIZ_SEARCH);
  }

  void changeCategory(int index) {
    if (savedCategories.isEmpty) {
      return;
    }
    selectCategorie.value = savedCategories[index];
    update();
    getQuestionsByCategory();
  }

  Future<void> getCategories() async {
    var cache = Hive.box('categories');
    savedCategories.value = cache.get('list') ?? RxList.empty();
    if (savedCategories.isEmpty) {
      var response = await RestApi.getCategories();
      if (response.status == Status.Success) {
        var cache = Hive.box('categories');
        cache.put('list', response.data);
        savedCategories.value = response.data;
      }
    }
  }

  Future<void> getQuestionsByCategory() async {
    onRefreshQuestion();
  }

  Future<void> getDefaultQuestion() async {
    statusQuestion.value = Status.Loading;
    selectCategorie.value = savedCategories.first;
    var response = await RestApi.getBundleQuestions(10, null, null);
    if (response.status == Status.Success) {
      questions.clear();
      questions.addAll(response.data);
    }
    statusQuestion.value = response.status;
  }

  Future<void> onRefreshQuestion() async {
    statusQuestion.value = Status.Loading;
    int? categoryId =
        selectCategorie.value.id == 1 ? null : selectCategorie.value.id;
    var response = await RestApi.getBundleQuestions(10, null, categoryId);
    if (response.status == Status.Success) {
      questions.clear();
      questions.addAll(response.data);
    }
    statusQuestion.value = questions.isEmpty ? Status.Empty : response.status;
  }

  void navigateToDetailQuestion(Question question) {
    Get.toNamed(Routes.QUIZ_DETAIL, arguments: question);
  }

  void setItemPageHeight(BuildContext context) {
    answerHeight = getScreenHeight(context) -
        bottomNavBarHeight -
        categoryHeight -
        toolBarHeight -
        30 -
        dividerHeight -
        buttonHeight;
  }
}
