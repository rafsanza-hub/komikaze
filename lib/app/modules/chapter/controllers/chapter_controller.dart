import 'package:get/get.dart';
import 'package:komikaze/app/data/models/chapter.dart';
import 'package:komikaze/app/data/services/comic_service.dart';
import 'package:komikaze/app/modules/chapter/views/chapter_view.dart';

class ChapterController extends GetxController {
  final ComicService _comicService = ComicService();

  var chapterData = ChapterData(
    chapter: DataChapter(
      chapterId: "",
      images: [],
      previousChapter: "",
      nextChapter: null,
      chapters: [],
    ),
    source: "",
  ).obs;

  var isLoading = false.obs;

  Future<void> fetchChapter(String comicId, String chapterId) async {
    try {
      isLoading(true);
      chapterData.value = await _comicService.fetchChapter(comicId, chapterId);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch chapter: $e');
    } finally {
      isLoading(false);
    }
  }

  void navigateToChapter(String? chapterId) {
    if (chapterId != null && chapterId.isNotEmpty) {
      final comicId = Get.arguments['comicId'] as String;
      Get.off(() => const ChapterView(),
          arguments: {'comicId': comicId, 'chapterId': chapterId});
    }
  }
}
