import 'package:flutter/cupertino.dart';
import 'package:poll_answer/core/utils/constants.dart';
import 'package:poll_answer/theme/colors.dart';

Container divider() {
  return Container(
    margin: const EdgeInsets.only(left: 16, right: 16),
    height: 0.5,
    width: double.infinity,
    color: dividerColor,
  );
}

Container dividerFullWidth() {
  return Container(
    height: 0.5,
    width: double.infinity,
    color: dividerColor,
  );
}

Container dividerText(String text) {
  return Container(
    height: dividerHeight,
    child: Row(
      children: [
        Spacer(),
        Container(
          height: 0.5,
          width: 100,
          color: dividerColor,
        ),
        Container(
          width: 100,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Text(
            text,
            style: const TextStyle(
                fontFamily: 'rubik', fontSize: 10, color: textColorType3),
          ),
        ),
        Container(
          width: 100,
          height: 0.5,
          color: dividerColor,
        ),
        Spacer(),
      ],
    ),
  );
}
