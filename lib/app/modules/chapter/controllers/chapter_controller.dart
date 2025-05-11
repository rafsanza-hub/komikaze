import 'package:get/get.dart';
import 'package:komikaze/app/data/models/chapter.dart';
import 'package:komikaze/app/data/services/comic_service.dart';
import 'package:komikaze/app/routes/app_pages.dart';

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

  Future<void> fetchChapter(String chapterId) async {
    try {
      isLoading(true);
      chapterData.value = await _comicService.fetchChapter(chapterId);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch chapter: $e');
    } finally {
      isLoading(false);
    }
  }

  void navigateToChapter(String? chapterId) {
    if (chapterId != null && chapterId.isNotEmpty) {
      Get.toNamed(Routes.CHAPTER, arguments: {'chapterId': chapterId});
    }
  }

  // In your ChapterController
  final showNavigation = true.obs;
  final showChapterList = false.obs;

  void toggleNavigationVisibility() {
    showNavigation.toggle();
    // Hide chapter list when hiding navigation
    if (!showNavigation.value) {
      showChapterList.value = false;
    }
  }

  void toggleChapterListVisibility() {
    showChapterList.toggle();
    // Ensure navigation is visible when showing chapter list
    if (showChapterList.value) {
      showNavigation.value = true;
    }
  }
}
