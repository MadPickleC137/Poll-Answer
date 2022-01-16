import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:poll_answer/api/api_response.dart';
import 'package:poll_answer/api/api_rest.dart';
import 'package:poll_answer/model/category.dart';
import 'package:poll_answer/navigation/routes.dart';

class QuizListConrtoller extends GetxController {
  RxBool isSearch = false.obs;
  Rx<Category> selectCategorie = Category(id: -1, name: 'All').obs;
  RxDouble toolBarHeight = 50.0.obs;
  RxList<Category> savedCategories = RxList.empty();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
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
  }

  void getCategories() async {
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
}
