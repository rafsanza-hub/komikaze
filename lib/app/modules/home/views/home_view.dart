import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:komikaze/app/modules/history/controllers/history_controller.dart';
import 'package:komikaze/app/modules/home/controllers/home_controller.dart';
import 'package:komikaze/app/routes/app_pages.dart';
import 'package:komikaze/app/widgets/custom_card_normal.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

const kBackgroundColor = Color(0xff121012);
const kButtonColor = Color.fromARGB(255, 89, 54, 133);
const kSearchbarColor = Color(0xff382C3E);

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroImage(context),
            const SizedBox(height: 20),
            const KomikCardsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroImage(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return _buildHeroImageSkeleton();
      }
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 390,
            child: PageView.builder(
              controller: controller.pageController,
              itemCount: controller.heroComics.length,
              onPageChanged: (value) => controller.currentPage.value = value,
              itemBuilder: (context, index) {
                final comic = controller.heroComics[index];
                return SizedBox(
                  width: double.infinity,
                  height: 390,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CachedNetworkImage(
                          imageUrl: comic['image']!,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          placeholder: (context, url) => Container(
                            color: kSearchbarColor,
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: kSearchbarColor,
                            child: const Icon(Icons.error),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                                kBackgroundColor.withOpacity(0.8),
                                kBackgroundColor,
                              ],
                              stops: const [0.0, 0.4, 0.75, 1.0],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 1,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              Text(
                                comic['subtitle']!.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 0),
                              Text(
                                comic['title']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: 200,
                                child: OutlinedButton(
                                  onPressed: () => Get.toNamed(
                                      Routes.COMIC_DETAIL,
                                      arguments: comic['comicId']),
                                  style: OutlinedButton.styleFrom(),
                                  child: const Text(
                                    'Read Now',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 25),
          SmoothPageIndicator(
            controller: controller.pageController,
            count: controller.heroComics.length,
            effect: SlideEffect(
              spacing: 8.0,
              radius: 30,
              dotWidth: 6,
              dotHeight: 6,
              paintStyle: PaintingStyle.fill,
              strokeWidth: 1.5,
              dotColor: Colors.grey.shade800,
              activeDotColor: Colors.grey,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildHeroImageSkeleton() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 390,
          color: kSearchbarColor,
        ),
        const SizedBox(height: 25),
        Container(
          height: 6,
          width: 100,
          color: kSearchbarColor,
        ),
      ],
    );
  }
}

class KomikCardsSection extends GetView<HomeController> {
  const KomikCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return _buildLoadingSkeleton();
      }
      if (controller.comicData.value.comicsList.isEmpty &&
          controller.popularKomikData.value.popularManga.isEmpty) {
        return const Center(
            child: Text('No comics available',
                style: TextStyle(color: Colors.white)));
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHistorySection(context),
            const SizedBox(height: 16),
            _buildSectionTitle(context, "top_10_popular".tr),
            const SizedBox(height: 8),
            _buildPopularGrid(context),
            const SizedBox(height: 16),
            _buildSectionTitle(context, "genre_selection".tr),
            const SizedBox(height: 8),
            _buildGenreChips(context),
            const SizedBox(height: 16),
            _buildSectionTitle(context, "latest".tr),
            const SizedBox(height: 8),
            _buildTerbaruGrid(context),
            const SizedBox(height: 16),
          ],
        ),
      );
    });
  }

  Widget _buildLoadingSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // History section skeleton
            Container(
              height: 140,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: kSearchbarColor,
              ),
            ),
            const SizedBox(height: 20),
            // Popular section skeleton
            Container(
              height: 20,
              width: 150,
              color: kSearchbarColor,
              margin: const EdgeInsets.only(bottom: 8),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 184,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    width: 120,
                    margin: const EdgeInsets.only(right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: kSearchbarColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 12,
                          width: 100,
                          color: kSearchbarColor,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 10,
                          width: 60,
                          color: kSearchbarColor,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Genre chips skeleton
            Container(
              height: 20,
              width: 150,
              color: kSearchbarColor,
              margin: const EdgeInsets.only(bottom: 8),
            ),
            const SizedBox(height: 8),
            Container(
              height: 36,
              margin: const EdgeInsets.only(bottom: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Container(
                    width: 80,
                    height: 36,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kSearchbarColor,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            // Latest section skeleton
            Container(
              height: 20,
              width: 150,
              color: kSearchbarColor,
              margin: const EdgeInsets.only(bottom: 8),
            ),
            const SizedBox(height: 8),
            GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.65,
                crossAxisSpacing: 8,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 144,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: kSearchbarColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 12,
                      color: kSearchbarColor,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 10,
                      width: 60,
                      color: kSearchbarColor,
                    ),
                    const SizedBox(height: 4),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistorySection(BuildContext context) {
    final history = controller.historyController.histories.first;

    return Container(
      height: 140,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              history.coverImage,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "last_read".tr,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                history.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: () {
                  Get.toNamed(Routes.COMIC_DETAIL, arguments: history.comicId);
                },
                icon: const Icon(
                  Icons.play_circle_outline,
                  color: Colors.white,
                  size: 20,
                ),
                label: Text(
                  'continue'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black38,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularGrid(BuildContext context) {
    final popularComics = controller.popularKomikData.value.popularManga;

    return Container(
      height: 180,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: popularComics.length,
        itemBuilder: (context, index) {
          final comic = popularComics[index];
          return Container(
            margin: const EdgeInsets.only(right: 5),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.COMIC_DETAIL, arguments: comic.comicId);
              },
              child: CustomCardNormal(
                title: comic.title,
                chapter: 'Rank ${comic.rank}',
                imageUrl: comic.image,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTerbaruGrid(BuildContext context) {
    final terbaruComics = controller.comicData.value.comicsList;
    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        crossAxisSpacing: 8,
      ),
      itemCount: terbaruComics.length,
      itemBuilder: (context, index) {
        final comic = terbaruComics[index];
        return GestureDetector(
          onTap: () {
            Get.toNamed(Routes.COMIC_DETAIL, arguments: comic.comicId);
          },
          child: CustomCardNormal(
            title: comic.title,
            chapter: comic.chapter,
            imageUrl: comic.image,
            type: comic.type,
          ),
        );
      },
    );
  }

  Widget _buildGenreChips(BuildContext context) {
    final genres = controller.genreController.genreData.value.genres;

    return Container(
      height: 36,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: genres.length,
        itemBuilder: (context, index) {
          final genre = genres[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ActionChip(
              backgroundColor: kSearchbarColor,
              side: BorderSide.none,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              label: Text(
                genre.name,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),
              onPressed: () {
                Get.toNamed(Routes.GENRE_DETAIL, arguments: genre.name);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (title == "Completed" ||
            title == "Terbaru" ||
            title == "Top 10 Popular")
          GestureDetector(
            onTap: () {
              // Navigate to full list
            },
            child: const Text(
              "See all",
              style: TextStyle(
                color: kButtonColor,
                fontSize: 17,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
      ],
    );
  }
}
