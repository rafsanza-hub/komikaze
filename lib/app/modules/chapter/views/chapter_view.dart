import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:komikaze/app/modules/chapter/controllers/chapter_controller.dart';
import 'package:komikaze/app/routes/app_pages.dart';
import 'dart:io';

class ChapterView extends GetView<ChapterController> {
  const ChapterView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.chapterData.value.chapter.images.isNotEmpty &&
          !controller.isOffline.value) {
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
            Container(
              height: 60,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left, size: 30),
                    color: chapter.previousChapter.isNotEmpty &&
                            !controller.isOffline.value
                        ? Colors.white
                        : Colors.grey,
                    onPressed: () {
                      if (chapter.previousChapter.isEmpty ||
                          controller.isOffline.value) {
                        return;
                      }
                      final previousChapter =
                          chapter.previousChapter.split('/').elementAt(4);
                      Get.toNamed(Routes.CHAPTER, arguments: {
                        'chapterId': previousChapter,
                        'comicId': Get.arguments['comicId'],
                        'comicTitle': Get.arguments['comicTitle'],
                      });
                    },
                  ),
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
                  IconButton(
                    icon: const Icon(Icons.chevron_right, size: 30),
                    color: chapter.nextChapter != null &&
                            !controller.isOffline.value
                        ? Colors.white
                        : Colors.grey,
                    onPressed: () {
                      // if (chapter.nextChapter == null ||
                      //     controller.isOffline.value) {
                      //   return;
                      // }
                      final nextChapter =
                          chapter.nextChapter!.split('/').elementAt(4);
                      print('Next chapter: $nextChapter');
                      Get.back();
                      Get.toNamed('chapter', arguments: {
                        'chapterId': nextChapter,
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildImage(String imageUrl, int index) {
    return Container(
      color: Colors.black,
      child: Obx(() => controller.isOffline.value
          ? Image.file(
              File(imageUrl),
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.error, color: Colors.red),
              ),
            )
          : CachedNetworkImage(
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
            )),
    );
  }

  Future<void> _preloadImages(
      BuildContext context, List<String> imageUrls) async {
    for (var url in imageUrls) {
      try {
        final provider = CachedNetworkImageProvider(url);
        await precacheImage(provider, context);
      } catch (e) {
        debugPrint('Error precaching image $url: $e');
      }
    }
  }
}
