import 'package:get/get.dart';

import '../modules/chapter/bindings/chapter_binding.dart';
import '../modules/chapter/views/chapter_view.dart';
import '../modules/comic_detail/bindings/comic_detail_binding.dart';
import '../modules/comic_detail/views/comic_detail_view.dart';
import '../modules/genre/bindings/genre_binding.dart';
import '../modules/genre/views/genre_view.dart';
import '../modules/genre_detail/bindings/genre_detail_binding.dart';
import '../modules/genre_detail/views/genre_detail_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.GENRE,
      page: () => const GenreView(),
      binding: GenreBinding(),
    ),
    GetPage(
      name: _Paths.COMIC_DETAIL,
      page: () => const ComicDetailView(),
      binding: ComicDetailBinding(),
    ),
    GetPage(
      name: _Paths.CHAPTER,
      page: () => const ChapterView(),
      binding: ChapterBinding(),
    ),
    GetPage(
      name: _Paths.GENRE_DETAIL,
      page: () => GenreDetailView(),
      binding: GenreDetailBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
    ),
  ];
}
