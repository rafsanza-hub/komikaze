import 'package:get/get.dart';
import 'package:komikaze/app/modules/download/views/download_view.dart';
import 'package:komikaze/app/modules/genre/views/genre_view.dart';
import 'package:komikaze/app/modules/history/views/history_view.dart';
import 'package:komikaze/app/modules/home/views/home_view.dart';
import 'package:komikaze/app/modules/profile/views/profile_view.dart';

class MainController extends GetxController {
  var index = 0.obs;

  void changeIndex(int newIndex) {
    index.value = newIndex;
  }

  List<dynamic> pages = [
    const HomeView(),
    const GenreView(),
    const HistoryView(),
    const DownloadView(),
    const ProfileView(),
  ];
}
