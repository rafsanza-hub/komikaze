import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komikaze/app/modules/genre_detail/controllers/genre_detail_controller.dart';
import 'package:komikaze/app/routes/app_pages.dart';
import 'package:komikaze/app/widgets/custom_card_normal.dart';

const kBackgroundColor = Color(0xff121012);

class GenreDetailView extends GetView<GenreDetailController> {
  const GenreDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
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
        if (controller.genreDetailData.value.comicsList.isEmpty) {
          return const Center(
            child: Text(
              'No comics available for this genre',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        final comics = controller.genreDetailData.value.comicsList;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.7,
              crossAxisSpacing: 8,
              mainAxisSpacing: 12,
            ),
            itemCount: comics.length,
            itemBuilder: (context, index) {
              final comic = comics[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.COMIC_DETAIL, arguments: comic.comicId);
                },
                child: CustomCardNormal(
                  title: comic.title,
                  episodeCount: comic.chapter,
                  imageUrl: comic.image,
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
