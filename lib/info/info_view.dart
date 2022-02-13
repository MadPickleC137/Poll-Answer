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
                  style: TextStyle(
                    fontFamily: 'rubik',
                    fontSize: 16,
                    color: textColorType3,
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
        padding: const EdgeInsets.only(top: 12, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            textItem(
                "1. Каждому пользователю разрешается проголосовать только один раз в одном опросе. "),
            dividerFullWidth(0.5),
            textItem(
                "2. Отсутствует возможность отмены голоса, поэтому будте аккуратне в выборе варианта ответа!"),
            dividerFullWidth(0.5),
            textItem(
                "3. Голосование проходит полностью анонимно, как для пользователя создавшего опрос, так и для его участников! "),
            dividerFullWidth(0.5),
            textItem(
                "4. В случае, если вы удалите приложение вы потеряете доступ к вашим опросам, которые вы создали. "),
            dividerFullWidth(0.5),
            textItem(
                "5. Максимальное количество создаваемых вариантов ответов равняется 5. "),
            dividerFullWidth(0.5),
            textItem(
                "6. Статистика по опросу для голосующих доступна только в процентном соотношении. "),
            dividerFullWidth(0.5),
            textItem(
                "7. Каждый опрос, (включая завершенные и активные) с момента создания существует в системе ровно один месяц, по истечению этого периода опрос удалится."),
            dividerFullWidth(0.5),
            textItem(
                "8. Пользователь создавший опрос(-ы) вправе завершить в любой момент времени созданные им опрос(-ы). Завершенные опросы могут быть доступны только пользователю создавшему их."),
            dividerFullWidth(0.5),
            textItem(
                "9. На текущем этапе мы не несем ответственности за содержание опросов. Сервис создавался только в развлекательных целях."),
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
