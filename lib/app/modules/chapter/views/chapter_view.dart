import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:komikaze/app/modules/chapter/controllers/chapter_controller.dart';
import 'package:komikaze/app/routes/app_pages.dart';

class ChapterView extends GetView<ChapterController> {
  const ChapterView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil comicId dan chapterId dari argumen navigasi
    final args = Get.arguments as Map<String, dynamic>;

    final chapterId = args['chapterId'] as String;
    controller.fetchChapter(chapterId);

    // Preload gambar setelah data dimuat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.chapterData.value.chapter.images.isNotEmpty) {
        _preloadImages(context, controller.chapterData.value.chapter.images);
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xff121012),
      body: Stack(
        children: [
          _buildContent(),
          _buildFloatingNavigation(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.chapterData.value.chapter.images.isEmpty) {
        return const Center(
            child: Text('No images available',
                style: TextStyle(color: Colors.white)));
      }
      final chapter = controller.chapterData.value.chapter;
      return GestureDetector(
        onTap: () {
          controller.toggleNavigationVisibility();
        },
        behavior: HitTestBehavior.opaque,
        child: ListView.builder(
          // Tingkatkan cacheExtent untuk memuat gambar di luar layar
          cacheExtent: 1000.0,
          itemCount: chapter.images.length,
          itemBuilder: (context, index) {
            return _buildImage(chapter.images[index], index);
          },
        ),
      );
    });
  }

  Widget _buildFloatingNavigation() {
    return Obx(() {
      if (!controller.showNavigation.value) return const SizedBox.shrink();

      final chapter = controller.chapterData.value.chapter;
      return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Column(
          children: [
            // Floating Navigation Bar
            Container(
              height: 60,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Previous Chapter Button
                  IconButton(
                      icon: const Icon(Icons.chevron_left, size: 30),
                      color: chapter.previousChapter.isNotEmpty
                          ? Colors.white
                          : Colors.grey,
                      onPressed: () {
                        if (chapter.previousChapter.isEmpty) return;
                        final previousChapter =
                            chapter.previousChapter.split('/').elementAt(4);

                        Get.offNamed('chapter/$previousChapter',
                            arguments: {'chapterId': previousChapter});
                      }),

                  // Comic Title
                  Expanded(
                    child: Center(
                      child: Text(
                        controller.chapterData.value.chapter.chapterId,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  // Next Chapter Button
                  IconButton(
                      icon: const Icon(Icons.chevron_right, size: 30),
                      color: chapter.nextChapter != null
                          ? Colors.white
                          : Colors.grey,
                      onPressed: () {
                        if (chapter.nextChapter == null) return;
                        final nextChapter =
                            chapter.nextChapter!.split('/').elementAt(4);

                        Get.offNamed('chapter/$nextChapter',
                            arguments: {'chapterId': nextChapter});
                      }),
                ],
              ),
            ),

            // Chapter List
            // if (controller.chapterData.value.chapter.chapters.isEmpty)
            //   Container(
            //     height: 80,
            //     padding: const EdgeInsets.symmetric(horizontal: 16),
            //     child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: chapter.chapters.length,
            //       itemBuilder: (context, index) {
            //         final chapterElement = chapter.chapters[index];
            //         return Padding(
            //           padding: const EdgeInsets.only(right: 8),
            //           child: ActionChip(
            //             backgroundColor:
            //                 chapterElement.chapterId == chapter.chapterId
            //                     ? Colors.purple
            //                     : Colors.grey[800],
            //             label: Text(
            //               chapterElement.title,
            //               style: const TextStyle(color: Colors.white),
            //             ),
            //             onPressed: () {
            //               controller
            //                   .navigateToChapter(chapterElement.chapterId);
            //             },
            //           ),
            //         );
            //       },
            //     ),
            //   ),
          ],
        ),
      );
    });
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
