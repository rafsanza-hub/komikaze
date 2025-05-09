import 'package:get/get.dart';

import '../controllers/genre_detail_controller.dart';

class GenreDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenreDetailController>(
      () => GenreDetailController(),
    );
  }
}
