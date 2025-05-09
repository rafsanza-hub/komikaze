import 'package:get/get.dart';
import 'package:komikaze/app/modules/genre/controllers/genre_controller.dart';
import 'package:komikaze/app/modules/home/controllers/home_controller.dart';

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
  }
}
