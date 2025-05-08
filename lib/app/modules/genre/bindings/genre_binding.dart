import 'package:get/get.dart';

import '../controllers/genre_controller.dart';

class GenreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenreController>(
      () => GenreController(),
    );
  }
}
