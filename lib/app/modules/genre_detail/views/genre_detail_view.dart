import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komikaze/app/core/constants/colors.dart';
import 'package:komikaze/app/modules/genre_detail/controllers/genre_detail_controller.dart';
import 'package:komikaze/app/routes/app_pages.dart';
import 'package:komikaze/app/widgets/custom_card_normal.dart';


class GenreDetailView extends GetView<GenreDetailController> {
  const GenreDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    // Deteksi akhir scroll untuk infinite scroll
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent * 0.8 &&
          controller.hasMoreData.value &&
          !controller.isLoadingMore.value) {
        controller.fetchNextPage(Get.arguments as String);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          Get.arguments ?? 'Genre',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.comicsList.isEmpty) {
          return const Center(
            child: Text(
              'No comics available for this genre',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CustomScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 200,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final comic = controller.comicsList[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.COMIC_DETAIL,
                            arguments: comic.comicId);
                      },
                      child: CustomCardNormal(
                        title: comic.title,
                        chapter: comic.chapter,
                        imageUrl: comic.image,
                      ),
                    );
                  },
                  childCount: controller.comicsList.length,
                ),
              ),
              SliverToBoxAdapter(
                child: Obx(() => controller.isLoadingMore.value
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : const SizedBox.shrink()),
              ),
            ],
          ),
        );
      }),
    );
  }
}
