import 'package:get/get.dart';
import 'package:komikaze/app/modules/bookmark/controllers/bookmark_controller.dart';
import 'package:komikaze/app/modules/download/controllers/download_controller.dart';
import 'package:komikaze/app/modules/genre/controllers/genre_controller.dart';
import 'package:komikaze/app/modules/history/controllers/history_controller.dart';
import 'package:komikaze/app/modules/home/controllers/home_controller.dart';
import 'package:komikaze/app/modules/profile/controllers/profile_controller.dart';
import 'package:komikaze/app/modules/search/controllers/search_controller.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<GenreController>(
      () => GenreController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<HistoryController>(
      () => HistoryController(),
    );
    Get.lazyPut<DownloadController>(
      () => DownloadController(),
    );
    Get.lazyPut<SearchController>(
      () => SearchController(),
    );
    Get.lazyPut<BookmarkController>(
      () => BookmarkController(),
    );
  }
}
