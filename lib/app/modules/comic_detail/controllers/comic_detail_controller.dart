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

  @override
  void onInit() {
    super.onInit();
    // Pulihkan status download dari GetStorage
    _syncDownloadingChapters();
    // Pantau perubahan GetStorage secara real-time
    _storage.listenKey('downloadingChapters', (value) {
      print('GetStorage downloadingChapters updated: $value');
      _syncDownloadingChapters();
    });

    // Ambil comicId dari argumen dan panggil fetchComicDetail
    final comicId = Get.arguments as String?;
    if (comicId != null) {
      fetchComicDetail(comicId);
    } else {
      print('Error: No comicId provided');
      Get.snackbar('Error', 'no_comic_id'.tr);
    }
  }

  void _syncDownloadingChapters() {
    final downloading =
        _storage.read<Map<String, dynamic>>('downloadingChapters') ?? {};
    downloadingChapters.assignAll(downloading
        .map((key, value) => MapEntry(key, (value as num).toDouble())));
    print('Synced downloadingChapters: $downloadingChapters');
  }

  Future<void> fetchComicDetail(String comicId) async {
    try {
      isLoading(true);
      comicDetailData.value = await _comicService.fetchComicDetail(comicId);
      print('Fetched comic: ${comicDetailData.value.comicDetail.title}');
    } catch (e) {
      print('Error fetching comic detail: $e');
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
      await _storage.write('downloadingChapters', downloadingChapters);
      await _storage.save();
      print('Starting download for chapter: ${chapter.chapterId}');

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
        await _storage.write('downloadingChapters', downloadingChapters);
        await _storage.save();
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
      await _storage.write('downloadingChapters', downloadingChapters);
      await _storage.save();
      print('Cleared downloadingChapters: $downloadingChapters');
    }
  }

  bool isChapterDownloaded(String chapterId) {
    final downloadedChapters =
        _storage.read<List<dynamic>>('downloadedChapters') ?? [];
    return downloadedChapters.any((json) => json['chapterId'] == chapterId);
  }
}
