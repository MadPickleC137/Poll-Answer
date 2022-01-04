import 'package:get/get.dart';
import 'package:poll_answer/navigation/routes.dart';

class QuizListConrtoller extends GetxController {
  RxBool isSearch = false.obs;
  RxString selectCategorie = "".obs;
  RxDouble toolBarHeight = 50.0.obs;

  List<String> categories = <String>[
    "Популярные",
    "Мои",
    "Новые",
    "Авто",
    "Еда",
    "Спорт",
    "Чувства",
    "Мемы"
  ];

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
    if (categories.isEmpty) {
      return;
    }
    selectCategorie.value = categories[index];
    update();
  }
}
