// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:poll_answer/create_quiz/quiz_create_controller.dart';
import 'package:poll_answer/model/category.dart';

class QuizCreateView extends StatelessWidget {
  final _controller = Get.put(CreateController());

  @override
  Widget build(BuildContext context) {
    _controller.getCategories();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          children: body(context),
        ),
      ),
    );
  }

  List<Widget> body(BuildContext context) {
    return [
      Obx(() => DropdownButtonFormField(
            hint: Text(
              'Катерогия',
            ),
            onChanged: (newValue) {
              _controller.setSelectedCategory(newValue as Category);
            },
            value: _controller.selectedCat.value,
            items: _controller.savedCategories.map((selectedType) {
              return DropdownMenuItem(
                child: Text(
                  selectedType.name,
                ),
                value: selectedType,
              );
            }).toList(),
          )),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Container(
          height: 45,
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Заголовок',
            ),
          ),
        ),
      ),
    ];
  }
}
