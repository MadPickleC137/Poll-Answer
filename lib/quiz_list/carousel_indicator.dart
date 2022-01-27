import 'package:flutter/cupertino.dart';
import 'package:poll_answer/theme/app_theme.dart';
import 'package:poll_answer/theme/colors.dart';

class CarouselIndicator extends StatelessWidget {
  CarouselIndicator({required this.count, required this.selected});

  final int count;
  final int selected;
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
          margin: EdgeInsets.only(left: 3, right: 3, bottom: 10),
          decoration: BoxDecoration(
              boxShadow: i == selected ? indicatorShadow : null,
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              color: i == selected ? dividerColor : darkBackground3),
        )
    ];
  }
}
