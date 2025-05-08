import 'package:get/get.dart';

import '../modules/comic_detail/bindings/comic_detail_binding.dart';
import '../modules/comic_detail/views/comic_detail_view.dart';
import '../modules/genre/bindings/genre_binding.dart';
import '../modules/genre/views/genre_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

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
  ];
}
