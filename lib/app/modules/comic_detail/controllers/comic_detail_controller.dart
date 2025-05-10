import 'package:get/get.dart';
import 'package:komikaze/app/data/models/comic_detail.dart';
import 'package:komikaze/app/data/services/comic_service.dart';

class ComicDetailController extends GetxController {
  final ComicService _comicService = ComicService();

  var comicDetailData = ComicDetailData(
    comicDetail: ComicDetail(
      comicId: '',
      coverImage: "",
      title: "",
      nativeTitle: "",
      genres: [],
      releaseYear: "",
      author: "",
      status: "",
      type: "",
      totalChapters: "0",
      updatedOn: "",
      rating: "0.0",
      synopsis: "",
      chapters: [],
    ),
    source: "",
  ).obs;

  var isLoading = false.obs;

  Future<void> fetchComicDetail(String comicId) async {
    try {
      isLoading(true);
      comicDetailData.value = await _comicService.fetchComicDetail(comicId);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch comic detail: $e');
    } finally {
      isLoading(false);
    }
  }

  final filteredChapters = <Chapter>[].obs;

  void filterChapters(String query) {
    if (query.isEmpty) {
      filteredChapters.clear();
      return;
    }

    final comic = comicDetailData.value.comicDetail;
    filteredChapters.assignAll(comic.chapters
        .where((chapter) =>
            chapter.title.toLowerCase().contains(query.toLowerCase()))
        .toList());
  }
}
