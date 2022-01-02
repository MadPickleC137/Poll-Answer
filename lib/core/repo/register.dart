import 'package:hive_flutter/hive_flutter.dart';
import 'package:poll_answer/core/repo/user_dto.dart';

void registerAdapters() {
  Hive.initFlutter();
  Hive.registerAdapter(UserDto());
}
