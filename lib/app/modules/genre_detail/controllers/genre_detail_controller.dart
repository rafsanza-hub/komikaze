import 'package:get/get.dart';
import 'package:komikaze/app/data/models/comic.dart';
import 'package:komikaze/app/data/services/genre_service.dart';

class GenreDetailController extends GetxController {
  final _genreService = GenreService();

  var genreDetailData = ComicData(
    comicsList: [],
    source: '',
  ).obs;
  var isLoading = true.obs;

  Future<void> fetchGenreDetail(String genre) async {
    try {
      isLoading(true);
      genreDetailData.value = await _genreService.fetchGenreDetail(genre);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch genres: $e');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    print(Get.arguments + 'ksksksks');
    fetchGenreDetail(Get.arguments);
    super.onInit();
  }
}
