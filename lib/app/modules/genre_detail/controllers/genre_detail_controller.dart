import 'package:get/get.dart';
import 'package:komikaze/app/data/models/comic.dart';
import 'package:komikaze/app/data/services/genre_service.dart';

class GenreDetailController extends GetxController {
  final GenreService _genreService = GenreService();

  var comicsList = RxList<ComicsList>([]);
  var isLoading = true.obs;
  var isLoadingMore = false.obs;
  var currentPage = 1.obs;
  var hasMoreData = true.obs;

  Future<void> fetchGenreDetail(String genre, {int page = 1}) async {
    try {
      if (page == 1) {
        isLoading(true);
      } else {
        isLoadingMore(true);
      }
      final data = await _genreService.fetchGenreDetail(genre, page: page);
      if (page == 1) {
        comicsList.assignAll(data.comicsList);
      } else {
        comicsList.addAll(data.comicsList);
      }
      currentPage.value = page;
      hasMoreData.value = data.pagination?.nextPage != null;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch genre comics: $e');
    } finally {
      if (page == 1) {
        isLoading(false);
      } else {
        isLoadingMore(false);
      }
    }
  }

  void fetchNextPage(String genre) {
    if (hasMoreData.value && !isLoadingMore.value) {
      fetchGenreDetail(genre, page: currentPage.value + 1);
    }
  }

  @override
  void onInit() {
    final genre = Get.arguments as String;
    fetchGenreDetail(genre);
    super.onInit();
  }
}
