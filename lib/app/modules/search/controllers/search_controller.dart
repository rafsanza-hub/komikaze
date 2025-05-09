import 'package:get/get.dart';
import 'package:komikaze/app/data/models/comic.dart';
import 'package:komikaze/app/data/services/comic_service.dart';

class SearchController extends GetxController {
  final ComicService _comicService = ComicService();

  var comicsList = RxList<ComicsList>([]);
  var isLoading = false.obs;
  var query = ''.obs;

  Future<void> searchComics(String searchQuery) async {
    if (searchQuery.isEmpty) {
      comicsList.clear();
      return;
    }
    try {
      isLoading(true);
      query.value = searchQuery;
      final data = await _comicService.searchComics(searchQuery);
      comicsList.assignAll(data.comicsList);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch search results: $e');
    } finally {
      isLoading(false);
    }
  }

  void clearSearch() {
    query.value = '';
    comicsList.clear();
  }
}
