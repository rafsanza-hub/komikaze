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
                itemCount: chapter.images.length,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: chapter.images[index],
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  );
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
}
