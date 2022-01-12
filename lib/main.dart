// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:poll_answer/core/di/bindings.dart';
import 'package:poll_answer/core/repo/register.dart';
import 'package:poll_answer/navigation/bottom_nav_bar.dart';
import 'package:poll_answer/navigation/pages.dart';
import 'package:poll_answer/theme/app_theme.dart';

Future<void> main() async {
  registerAdapters();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: [Locale('en'), Locale('ru')],
      fallbackLocale: const Locale('ru'),
      startLocale: const Locale('ru'),
      child: const PollAnswerApp()));
}

class PollAnswerApp extends StatelessWidget {
  const PollAnswerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      initialBinding: ControllersBinding(),
      getPages: Pages.list,
      theme: appTheme(context),
      title: tr('app-name'),
      home: Navigation(),
    );
  }
}
