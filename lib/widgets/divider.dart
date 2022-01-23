import 'package:flutter/cupertino.dart';
import 'package:poll_answer/theme/colors.dart';

Container divider() {
  return Container(
    margin: const EdgeInsets.only(left: 16, right: 16),
    height: 1,
    width: double.infinity,
    color: dividerColor,
  );
}
