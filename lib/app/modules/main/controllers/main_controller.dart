import 'package:get/get.dart';
import 'package:komikaze/app/modules/home/views/home_view.dart';

class MainController extends GetxController {
  var index = 0.obs;

  void changeIndex(int newIndex) {
    index.value = newIndex;
  }

  List pages = [
    HomeView(),
    HomeView(),
    HomeView(),
    HomeView(),
  ];
}
