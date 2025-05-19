import 'package:get/get.dart';
import 'package:komikaze/app/data/models/chapter.dart';
import 'package:komikaze/app/data/services/comic_service.dart';
import 'package:komikaze/app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';

class ChapterController extends GetxController {
  final ComicService _comicService = ComicService();
  final GetStorage _storage = GetStorage();
  // final args =  as Map<String, dynamic>;
  final chapterId = Get.arguments['chapterId'];

  var chapterData = ChapterData(
    chapter: DataChapter(
      chapterId: '',
      images: [],
      previousChapter: '',
      nextChapter: null,
      chapters: [],
    ),
    source: '',
  ).obs;

  var isLoading = false.obs;
  var isOffline = false.obs;
  var localImages = <String>[].obs;

  Future<void> fetchChapter(String chapterId) async {
    try {
      isLoading(true);
      final downloadedChapters =
          _storage.read<List<dynamic>>('downloadedChapters') ?? [];
      final downloadedChapter = downloadedChapters.firstWhereOrNull(
        (json) => json['chapterId'] == chapterId,
      );

      if (downloadedChapter != null) {
        isOffline.value = true;
        localImages
            .assignAll(List<String>.from(downloadedChapter['localImagePaths']));
        chapterData.value = ChapterData(
          chapter: DataChapter(
            chapterId: chapterId,
            images: localImages,
            previousChapter: '',
            nextChapter: null,
            chapters: [],
          ),
          source: 'local',
        );
      } else {
        isOffline.value = false;
        chapterData.value = await _comicService.fetchChapter(chapterId);
      }
    } catch (e) {
      // Get.snackbar('Error', 'Failed to fetch chapter: $e');
      print('Error fetching chapter: $e');
    } finally {
      isLoading(false);
    }
  }

  void navigateToChapter(String? chapterId) {
    if (chapterId != null && chapterId.isNotEmpty) {
      Get.toNamed(Routes.CHAPTER, arguments: {
        'chapterId': chapterId,
        'comicId': Get.arguments['comicId'],
        'comicTitle': Get.arguments['comicTitle'],
      });
    }
  }

  final showNavigation = true.obs;
  final showChapterList = false.obs;

  void toggleNavigationVisibility() {
    showNavigation.toggle();
    if (!showNavigation.value) {
      showChapterList.value = false;
    }
  }

  void toggleChapterListVisibility() {
    showChapterList.toggle();
    if (showChapterList.value) {
      showNavigation.value = true;
    }
  }

  @override
  void onInit() {
    fetchChapter(chapterId);

    super.onInit();
  }
}
