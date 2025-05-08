import 'package:get/get.dart';

import '../controllers/chapter_controller.dart';

class ChapterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChapterController>(
      () => ChapterController(),
    );
  }
}
