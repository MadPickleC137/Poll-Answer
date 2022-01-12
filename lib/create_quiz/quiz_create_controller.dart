// ignore_for_file: invalid_use_of_protected_member

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:poll_answer/api/api_response.dart';
import 'package:poll_answer/api/api_rest.dart';
import 'package:poll_answer/model/answer.dart';
import 'package:poll_answer/model/category.dart';

class CreateController extends GetxController {
  Rx<Category?> selectedCat = Category(id: 1, name: 'All').obs;
  RxString title = "".obs;
  RxString description = "".obs;
  RxList<Answer> variants = RxList.empty();
  RxList<Category> savedCategories = RxList.empty();
  RxInt countAnswer = 1.obs;

  Map<int, TextEditingController> editTextVariants = {};

  void setSelectedCategory(Category cat) {
    selectedCat.value = cat;
  }

  @override
  void onInit() {}

  @override
  void onReady() {}

  void getCategories() async {
    var cache = Hive.box('categories');
    savedCategories.value = cache.get('list') ?? RxList.empty();
    if (savedCategories.value.isEmpty) {
      var response = await RestApi.getCategories();
      if (response.status == Status.Success) {
        var cache = Hive.box('categories');
        cache.put('list', response.data);
        savedCategories.value = response.data;
      }
    }
  }

  void navigateToBack() {
    Get.back();
  }

  void addNewVariant() {
    if (variants.length < 5) {
      var id = Random().nextInt(9999);
      editTextVariants.addAll({id: TextEditingController()});
      variants.add(Answer(id: Random().nextInt(9999), votedCount: 0, text: ""));
    }
  }

  void deleteItemVariant(int id) {
    var findVariant = variants.firstWhereOrNull(
      (element) => element.id == id,
    );
    if (findVariant != null) {
      variants.removeWhere((variant) => variant.id == id);
    }
  }
}
