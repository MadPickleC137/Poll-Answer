import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:poll_answer/core/utils/constants.dart';
import 'package:poll_answer/theme/app_theme.dart';
import 'package:poll_answer/theme/colors.dart';
import 'package:poll_answer/widgets/decoration_app_bar.dart';
import 'package:poll_answer/widgets/divider.dart';

class InfoView extends StatelessWidget {
  TextStyle ruleTitleTextStyle = const TextStyle(
    fontFamily: 'rubik',
    fontSize: 16,
    color: textColorType3,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  PreferredSize _appBar(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: Size(width, appBarHeight),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        decoration: decorationAppBar(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: FloatingSearchBarAction(
                showIfOpened: false,
                child: CircularButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: iconColorWhite,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  tr('info_title'),
                  style: ruleTitleTextStyle,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 12, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            textItem(tr('rule_1')),
            dividerFullWidth(0.5),
            textItem(tr('rule_2')),
            dividerFullWidth(0.5),
            textItem(tr('rule_3')),
            dividerFullWidth(0.5),
            textItem(tr('rule_4')),
            dividerFullWidth(0.5),
            textItem(tr('rule_5')),
            dividerFullWidth(0.5),
            textItem(tr('rule_6')),
            dividerFullWidth(0.5),
            textItem(tr('rule_7')),
            dividerFullWidth(0.5),
            textItem(tr('rule_8')),
            dividerFullWidth(0.5),
            textItem(tr('rule_9')),
          ],
        ),
      ),
    );
  }

  Widget textItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
      child: Text(
        text,
        style: messageTextStyle,
        textAlign: TextAlign.left,
      ),
    );
  }
}
