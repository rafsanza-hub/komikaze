import 'package:get/get.dart';
import 'package:komikaze/app/data/models/comic.dart';
import 'package:komikaze/app/data/models/popular_comic.dart';
import 'package:komikaze/app/data/services/comic_service.dart';
import 'package:komikaze/app/modules/genre/controllers/genre_controller.dart';

class HomeController extends GetxController {
  final ComicService _comicService = ComicService();
  final GenreController genreController = Get.find();

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
  var popularKomikData = PopularKomikData(popularManga: [], source: "").obs;

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

  Future<void> fetchPopularComics() async {
    try {
      isLoading(true);
      popularKomikData.value = await _comicService.fetchPopularComics();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch popular comics: $e');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    genreController.fetchGenres();
    fetchComics();
    fetchPopularComics();
    print('genre: ${genreController.genreData.value.genres}');
    super.onInit();
  }
}
