import 'package:flutter/cupertino.dart';
import 'package:poll_answer/theme/app_theme.dart';
import 'package:poll_answer/theme/colors.dart';

class CarouselIndicator extends StatelessWidget {
  CarouselIndicator(
      {required this.count,
      required this.selected,
      this.colorIndicator = darkBackground3});

  final int count;
  final int selected;
  final Color colorIndicator;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: indicators(),
    );
  }

  List<Widget> indicators() {
    return [
      for (int i = 0; i < count; i++)
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(left: 3, right: 3, bottom: 10),
          decoration: BoxDecoration(
              boxShadow: i == selected ? indicatorShadow : null,
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              color: i == selected ? dividerColor : colorIndicator),
        )
    ];
  }
}
