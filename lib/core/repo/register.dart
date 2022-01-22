import 'package:hive_flutter/hive_flutter.dart';
import 'package:poll_answer/core/repo/answer_dto.dart';
import 'package:poll_answer/core/repo/category_dto.dart';
import 'package:poll_answer/core/repo/user_dto.dart';

void registerAdapters() {
  Hive.initFlutter();
  Hive.registerAdapter(UserDto());
  Hive.registerAdapter(CategoryDto());
  Hive.registerAdapter(QuestionDto());
}
