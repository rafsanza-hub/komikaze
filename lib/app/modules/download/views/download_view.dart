import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komikaze/app/modules/download/controllers/download_controller.dart';
import 'package:komikaze/app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';

const kBackgroundColor = Color(0xff121012);
const kSearchbarColor = Color(0xff382C3E);

class DownloadsView extends GetView<DownloadsController> {
  const DownloadsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Downloads',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.downloadedChapters.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.download,
                  color: Colors.white54,
                  size: 100,
                ),
                const SizedBox(height: 16),
                const Text(
                  'No downloaded chapters',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Download chapters from Comic Detail to read offline',
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 89, 54, 133),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => Get.toNamed(Routes.HOME),
                  child: const Text('Browse Comics'),
                ),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          separatorBuilder: (context, index) => const SizedBox(height: 5),
          itemCount: controller.downloadedChapters.length,
          itemBuilder: (context, index) {
            final chapter = controller.downloadedChapters[index];
            return Card(
              color: kSearchbarColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    chapter.coverImage,
                    width: 45,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                  ),
                ),
                title: Text(
                  chapter.comicTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  chapter.chapterTitle.replaceAll(RegExp(r'\s+'), ' ').trim(),
                  style: const TextStyle(color: Colors.white54),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white54),
                  onPressed: () {
                    Get.defaultDialog(
                      title: 'Delete Chapter',
                      content: Text(
                          'Are you sure you want to delete ${chapter.chapterTitle}?'),
                      confirm: TextButton(
                        onPressed: () {
                          controller.deleteChapter(chapter);
                          Get.back();
                        },
                        child: const Text('Delete'),
                      ),
                      cancel: TextButton(
                        onPressed: () => Get.back(),
                        child: const Text('Cancel'),
                      ),
                    );
                  },
                ),
                onTap: () {
                  Get.toNamed(Routes.CHAPTER, arguments: {
                    'chapterId': chapter.chapterId,
                    'comicId': chapter.comicId,
                    'comicTitle': chapter.comicTitle,
                  });
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final chapters =
              GetStorage().read<List<dynamic>>('downloadedChapters') ?? [];
          print('GetStorage content: $chapters');
          print(
              'Current downloadedChapters: ${controller.downloadedChapters.map((c) => c.toJson())}');
        },
        child: const Icon(Icons.bug_report),
        backgroundColor: const Color.fromARGB(255, 89, 54, 133),
      ),
    );
  }
}
