import 'package:get/get.dart';
import 'package:komikaze/app/data/models/downloaded_chapter.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class DownloadsController extends GetxController {
  final GetStorage _storage = GetStorage();
  var downloadedChapters = <DownloadedChapter>[].obs;

  @override
  void onInit() {
    loadDownloadedChapters();
    // Dengarkan perubahan pada GetStorage
    _storage.listenKey('downloadedChapters', (value) {
      print('GetStorage updated: $value');
      loadDownloadedChapters();
    });
    super.onInit();
  }

  void loadDownloadedChapters() {
    try {
      final chapters = _storage.read<List<dynamic>>('downloadedChapters') ?? [];
      print('Loaded chapters from storage: $chapters');
      final uniqueChapters = <DownloadedChapter>[];
      final seenChapterIds = <String>{};

      for (var json in chapters) {
        try {
          final chapter = DownloadedChapter.fromJson(json);
          if (!seenChapterIds.contains(chapter.chapterId)) {
            uniqueChapters.add(chapter);
            seenChapterIds.add(chapter.chapterId);
          } else {
            print('Skipping duplicate chapter: ${chapter.chapterId}');
          }
        } catch (e) {
          print('Error parsing chapter: $json, Error: $e');
        }
      }

      downloadedChapters.assignAll(uniqueChapters);
      print('Parsed downloadedChapters: ${downloadedChapters.length} chapters');
    } catch (e) {
      print('Error loading downloaded chapters: $e');
      downloadedChapters.clear();
      Get.snackbar('Error', 'Failed to load downloaded chapters: $e');
    }
  }

  Future<void> deleteChapter(DownloadedChapter chapter) async {
    try {
      final dir = Directory(
          '${(await getApplicationDocumentsDirectory()).path}/chapters/${chapter.comicId}/${chapter.chapterId}');
      if (await dir.exists()) {
        await dir.delete(recursive: true);
        print('Deleted directory: ${dir.path}');
      }
      downloadedChapters.removeWhere((c) => c.chapterId == chapter.chapterId);
      await _storage.write('downloadedChapters',
          downloadedChapters.map((c) => c.toJson()).toList());
      print(
          'Updated storage after deletion: ${downloadedChapters.length} chapters remaining');
      Get.snackbar('Success', 'Chapter deleted successfully');
    } catch (e) {
      print('Error deleting chapter: $e');
      Get.snackbar('Error', 'Failed to delete chapter: $e');
    }
  }
}
