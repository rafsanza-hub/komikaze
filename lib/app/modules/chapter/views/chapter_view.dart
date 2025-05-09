import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:komikaze/app/modules/chapter/controllers/chapter_controller.dart';

class ChapterView extends GetView<ChapterController> {
  const ChapterView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil comicId dan chapterId dari argumen navigasi
    final args = Get.arguments as Map<String, dynamic>;
    final comicId = args['comicId'] as String;
    final chapterId = args['chapterId'] as String;
    controller.fetchChapter(comicId, chapterId);

    // Preload gambar setelah data dimuat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.chapterData.value.chapter.images.isNotEmpty) {
        _preloadImages(context, controller.chapterData.value.chapter.images);
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xff121012),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Chapter Reader'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.chapterData.value.chapter.images.isEmpty) {
          return const Center(
              child: Text('No images available',
                  style: TextStyle(color: Colors.white)));
        }
        final chapter = controller.chapterData.value.chapter;
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                // Tingkatkan cacheExtent untuk memuat gambar di luar layar
                cacheExtent: 1000.0,
                itemCount: chapter.images.length,
                itemBuilder: (context, index) {
                  return _buildImage(chapter.images[index], index);
                },
              ),
            ),
            // Navigation Buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: chapter.previousChapter.isNotEmpty
                        ? () => controller
                            .navigateToChapter(chapter.previousChapter)
                        : null,
                    child: const Text('Previous'),
                  ),
                  ElevatedButton(
                    onPressed: chapter.nextChapter != null
                        ? () =>
                            controller.navigateToChapter(chapter.nextChapter)
                        : null,
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
            // Chapter List
            Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: chapter.chapters.length,
                itemBuilder: (context, index) {
                  final chapterElement = chapter.chapters[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ActionChip(
                      label: Text(chapterElement.title),
                      onPressed: () {
                        controller.navigateToChapter(chapterElement.chapterId);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  // Widget untuk menampilkan gambar dengan progres loading
  Widget _buildImage(String imageUrl, int index) {
    return Container(
      color: Colors.black,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.contain,
        placeholder: (context, url) => const Center(
          child: SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 8),
                Text(
                  'Loading image...',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
        errorWidget: (context, url, error) => const Center(
          child: Icon(Icons.error, color: Colors.red),
        ),
      ),
    );
  }

  // Fungsi untuk preload gambar secara berurutan
  Future<void> _preloadImages(
      BuildContext context, List<String> imageUrls) async {
    for (var url in imageUrls) {
      try {
        final provider = CachedNetworkImageProvider(url);
        await precacheImage(provider, context);
      } catch (e) {
        // Tangani error precache (opsional)
        debugPrint('Error precaching image $url: $e');
      }
    }
  }
}
