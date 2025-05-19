import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komikaze/app/core/constants/colors.dart';
import 'package:komikaze/app/modules/download/controllers/download_controller.dart';
import 'package:komikaze/app/routes/app_pages.dart';

class DownloadView extends GetView<DownloadController> {
  const DownloadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'downloads'.tr,
          style: const TextStyle(
            color: Colors.white,
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
                Text(
                  'no_downloaded_chapters'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  'download_instruction'.tr,
                  style: const TextStyle(color: Colors.white54, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => Get.toNamed(Routes.MAIN),
                  child: Text(
                    'browse_comics'.tr,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: controller.downloadedChapters.length,
          itemBuilder: (context, index) {
            final chapter = controller.downloadedChapters[index];
            return Card(
              margin: EdgeInsets.zero,
              color: AppColors.searchBar,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
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
                      title: 'delete_chapter'.tr,
                      content: Text('confirm_delete'
                          .trParams({'chapter': chapter.chapterTitle})),
                      confirm: TextButton(
                        onPressed: () {
                          controller.deleteChapter(chapter);
                          Get.back();
                        },
                        child: Text('delete'.tr),
                      ),
                      cancel: TextButton(
                        onPressed: () => Get.back(),
                        child: Text('cancel'.tr),
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
    );
  }
}
