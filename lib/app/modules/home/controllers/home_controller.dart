import 'package:get/get.dart';
import 'package:komikaze/app/data/models/comic.dart';
import 'package:komikaze/app/data/services/comic_service.dart';

class HomeController extends GetxController {
  final ComicService _comicService = ComicService();

  var comicData = ComicData(
    comicsList: [],
    page: 1,
    genres: [],
    status: "",
    type: "",
    orderby: "",
    source: "",
  ).obs;

  var isLoading = false.obs;

  Future<void> fetchComics() async {
    try {
      isLoading(true);
      comicData.value = await _comicService.fetchComics();
    } catch (e) {
      print('error cuy: $e');
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    fetchComics();
    super.onInit();
  }
}
