import 'package:flutter/widgets.dart';
import 'package:poll_answer/theme/colors.dart';

Container divider() {
  return Container(
    margin: const EdgeInsets.only(top: 5),
    width: double.infinity,
    height: 0.5,
    color: dividerColor,
  );
}
