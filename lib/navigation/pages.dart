import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:poll_answer/create_quiz/quiz_create_view.dart';
import 'package:poll_answer/navigation/routes.dart';
import 'package:poll_answer/profile/active/profile_active_quiz_view.dart';
import 'package:poll_answer/profile/closed/profile_closed_quiz_view.dart';
import 'package:poll_answer/profile/profile_view.dart';
import 'package:poll_answer/profile/statistic/profile_stat_quiz_view.dart';
import 'package:poll_answer/quiz_closing/quiz_closing_view.dart';
import 'package:poll_answer/quiz_list/quiz_list_view.dart';
import 'package:poll_answer/search/search_view.dart';

/**
 * Класс компонента навигации, содержит в себе ссылки на основные экраны приложения
 */
class Pages {
  static var list = [
    GetPage(
      name: Routes.QUIZ_LIST,
      page: () => ListQuizView(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfileView(),
    ),
    GetPage(
      name: Routes.PROFILE_ACTIVE,
      page: () => ProfileActiveQuizView(),
    ),
    GetPage(
      name: Routes.PROFILE_CLOSED,
      page: () => ProfileClosedQuizView(),
    ),
    GetPage(
      name: Routes.QUIZ_CREATE,
      page: () => QuizCreateView(),
    ),
    GetPage(
      name: Routes.QUIZ_STATISTIC,
      page: () => QuizStatisticView(),
    ),
    GetPage(
      name: Routes.QUIZ_CLOSING,
      page: () => QuizClosingView(),
    ),
    GetPage(
      name: Routes.QUIZ_SEARCH,
      page: () => SearchView(),
    ),
  ];
}
