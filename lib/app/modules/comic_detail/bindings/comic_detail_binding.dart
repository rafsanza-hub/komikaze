import 'package:get/get.dart';

import '../controllers/comic_detail_controller.dart';

class ComicDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComicDetailController>(() => ComicDetailController());
  }
}
