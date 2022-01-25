// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poll_answer/api/api_response.dart';
import 'package:poll_answer/api/api_rest.dart';
import 'package:poll_answer/model/answer.dart';
import 'package:poll_answer/model/category.dart';
import 'package:poll_answer/model/question.dart';

class CreateController extends GetxController {
  Rx<Category?> selectedCat = Category(id: 1, name: 'All').obs;
  RxString title = "".obs;
  RxString description = "".obs;
  RxList<Answer> variants = RxList.empty();
  RxList<Category> savedCategories = RxList.empty();
  RxInt countAnswer = 1.obs;
  List<TextEditingController> editTextControllers = [];
  final ImagePicker _picker = ImagePicker();

  var descTextController = TextEditingController();

  var titleTextController = TextEditingController();

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
      editTextControllers.add(TextEditingController());
      variants.add(Answer(id: Random().nextInt(9999), votedCount: 0, text: ""));
    }
  }

  void deleteItemVariant(int index) {
    variants.removeAt(index);
    editTextControllers.removeAt(index);
  }

  Future<void> pickPhoto(ImageSource source, int index) async {
    final XFile? image = await _picker.pickImage(
        source: source, maxHeight: 1080, maxWidth: 1920, imageQuality: 90);
    if (image == null) {
      return;
    } else {
      variants[index].image = image.path;
      var updateImageVariant = variants[index];
      variants[index] = updateImageVariant;
    }
  }

  Future<void> createQuestion() async {
    if (_checkTextVariants()) return;
    if (_checkTitleText()) return;
    if (_checkDescText()) return;
    if (_checkVariants()) return;
    for (int i = 0; i < variants.length; i++) {
      variants[i].text = editTextControllers[i].value.text;
      variants[i].image = await _parsePathToBase64(variants[i].image);
    }
    var question = Question(
        id: Random().nextInt(9999),
        isPollCompleted: false,
        title: titleTextController.value.text,
        description: descTextController.value.text,
        categoryId: selectedCat.value?.id,
        answerVariants: variants);
    var response = await RestApi.createQuestion(question);
    if (response.status == Status.Success) {
      Get.back();
    }
  }

  bool _checkTextVariants() =>
      editTextControllers
          .firstWhereOrNull((element) => (element.value.text.isEmpty)) !=
      null;

  bool _checkTitleText() => titleTextController.value.text.isEmpty;
  bool _checkDescText() => descTextController.value.text.isEmpty;
  bool _checkVariants() => variants.value.isEmpty;

  Future<String> _parsePathToBase64(String? image) async {
    if (image == null || image.isEmpty) return "";
    var file = File(image);
    return base64Encode(await file.readAsBytes());
  }
}
