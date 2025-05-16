import 'dart:io';
import 'package:get/get.dart';
import 'package:komikaze/app/data/models/comic_detail.dart';
import 'package:komikaze/app/data/models/downloaded_chapter.dart';
import 'package:komikaze/app/data/services/comic_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class ComicDetailController extends GetxController {
  final ComicService _comicService = ComicService();
  final GetStorage _storage = GetStorage();

  final comicId = Get.arguments as String;

  var comicDetailData = ComicDetailData(
    comicDetail: ComicDetail(
      comicId: '',
      coverImage: '',
      title: '',
      nativeTitle: '',
      genres: [],
      releaseYear: '',
      author: '',
      status: '',
      type: '',
      totalChapters: '0',
      updatedOn: '',
      rating: '0.0',
      synopsis: '',
      chapters: [],
    ),
    source: '',
  ).obs;

  var isLoading = false.obs;
  var downloadingChapters = <String, double>{}.obs;

  Future<void> fetchComicDetail(String comicId) async {
    try {
      isLoading(true);
      comicDetailData.value = await _comicService.fetchComicDetail(comicId);
    } catch (e) {
      Get.snackbar('Error', 'error_fetch'.trParams({'error': e.toString()}));
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

  Future<void> downloadChapter(Chapter chapter, String comicId,
      String comicTitle, String coverImage) async {
    try {
      downloadingChapters[chapter.chapterId] = 0.0;
      print('Starting download for chapter: ${chapter.chapterId}');

      // Verify GetStorage initialization
      if (!_storage.hasData('downloadedChapters')) {
        await _storage.write('downloadedChapters', []);
        print('Initialized downloadedChapters in GetStorage');
      }

      final chapterData = await _comicService.fetchChapter(chapter.chapterId);
      final images = chapterData.chapter.images;
      print('Fetched chapter data with ${images.length} images');

      final dir = await getApplicationDocumentsDirectory();
      final chapterDir =
          Directory('${dir.path}/chapters/$comicId/${chapter.chapterId}');
      await chapterDir.create(recursive: true);
      print('Created directory: ${chapterDir.path}');

      final localImagePaths = <String>[];
      for (var i = 0; i < images.length; i++) {
        final imageUrl = images[i];
        final response = await http.get(Uri.parse(imageUrl));
        final filePath = '${chapterDir.path}/image_$i.jpg';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        localImagePaths.add(filePath);
        downloadingChapters[chapter.chapterId] = (i + 1) / images.length;
        downloadingChapters.refresh();
        print('Downloaded image $i: $filePath');
      }

      final downloadedChapter = DownloadedChapter(
        comicId: comicId,
        chapterId: chapter.chapterId,
        comicTitle: comicTitle,
        chapterTitle: chapter.title,
        coverImage: coverImage,
        localImagePaths: localImagePaths,
        downloadedAt: DateTime.now(),
      );

      final downloadedChapters =
          _storage.read<List<dynamic>>('downloadedChapters') ?? [];
      if (!downloadedChapters
          .any((json) => json['chapterId'] == chapter.chapterId)) {
        downloadedChapters.add(downloadedChapter.toJson());
        try {
          await _storage.write('downloadedChapters', downloadedChapters);
          await _storage.save();
          print('Saved to storage: ${downloadedChapter.toJson()}');
          final savedData = _storage.read<List<dynamic>>('downloadedChapters');
          print('Verified storage after save: $savedData');
        } catch (e) {
          print('Error saving to GetStorage: $e');
          Get.snackbar(
              'Error', 'error_save_storage'.trParams({'error': e.toString()}));
          return;
        }
      } else {
        print(
            'Chapter ${chapter.chapterId} already exists in storage, skipping');
      }

      Get.snackbar('Success', 'success_download'.tr);
    } catch (e) {
      print('Error downloading chapter: $e');
      Get.snackbar('Error', 'error_download'.trParams({'error': e.toString()}));
    } finally {
      downloadingChapters.remove(chapter.chapterId);
    }
  }

  bool isChapterDownloaded(String chapterId) {
    final downloadedChapters =
        _storage.read<List<dynamic>>('downloadedChapters') ?? [];
    return downloadedChapters.any((json) => json['chapterId'] == chapterId);
  }

  @override
  void onInit() {
    fetchComicDetail(comicId);

    super.onInit();
  }
}
