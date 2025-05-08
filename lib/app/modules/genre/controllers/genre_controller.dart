import 'package:get/get.dart';
import 'package:komikaze/app/data/models/genre.dart';
import 'package:komikaze/app/data/services/genre_service.dart';

class GenreController extends GetxController {
  final _genreService = Get.put<GenreService>(GenreService());

  Rx<GenreData> genreData = GenreData(
    genres: [],
    source: '',
  ).obs;
  RxBool isLoading = false.obs;

  Future<void> fetchGenres() async {
    try {
      isLoading(true);
      print('kaka'+_genreService.fetchGenres().toString());
      genreData.value = await _genreService.fetchGenres();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch genres: $e');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    fetchGenres();
    super.onInit();
  }
}
