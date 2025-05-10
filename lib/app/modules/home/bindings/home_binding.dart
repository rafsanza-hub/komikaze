import 'package:get/get.dart';
import 'package:komikaze/app/modules/genre/controllers/genre_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<GenreController>(
      () => GenreController(),
    );
  }
}
