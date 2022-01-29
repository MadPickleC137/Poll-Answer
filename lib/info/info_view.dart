import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:poll_answer/core/utils/constants.dart';
import 'package:poll_answer/theme/colors.dart';
import 'package:poll_answer/widgets/decoration_app_bar.dart';

class InfoView extends StatelessWidget {
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
                    Icons.arrow_back_ios_outlined,
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
                  style: TextStyle(
                    fontFamily: 'rubik',
                    fontSize: 16,
                    color: appBarTextColor,
                  ),
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
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
