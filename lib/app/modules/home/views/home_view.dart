import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
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
        // physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildHeroImage(context),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       const Text(
            //         "Hi, Rafsan",
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 30,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       IconButton(
            //         icon: const Icon(
            //           Icons.search_rounded,
            //           color: Colors.white,
            //           size: 30,
            //         ),
            //         onPressed: () {
            //           Get.toNamed(Routes.SEARCH);
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 20),
            const KomikCardsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroImage(BuildContext context) {
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
                              comic['subtitle']!,
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
              activeDotColor: Colors.grey),
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
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.comicData.value.comicsList.isEmpty &&
          controller.popularKomikData.value.popularManga.isEmpty) {
        return const Center(
            child: Text('No comics available',
                style: TextStyle(color: Colors.white)));
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHistorySection(context),
          _buildSectionTitle(context, "Top 10 Popular"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _buildPopularGrid(context),
          ),
          _buildSectionTitle(context, "Genre pilihan"),
          _buildGenreChips(context),
          _buildSectionTitle(context, "Terbaru"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _buildTerbaruGrid(context),
          ),
          _buildSectionTitle(context, "Completed"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: _buildKomikGrid(context),
          ),
        ],
      );
    });
  }

  Widget _buildHistorySection(BuildContext context) {
    final lastComic = controller.comicData.value.comicsList.isNotEmpty
        ? controller.comicData.value.comicsList[0]
        : null;

    return Container(
      height: 140,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: lastComic != null
                ? const DecorationImage(
                    image: CachedNetworkImageProvider(
                        "https://i.pinimg.com/736x/84/5f/9d/845f9dab7240d5f249efc289dde4d7af.jpg"),
                    fit: BoxFit.cover,
                  )
                : null,
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
                const Text(
                  "Terakhir dilihat",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  lastComic?.title ?? "No history",
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
                    if (lastComic != null) {
                      Get.toNamed(Routes.COMIC_DETAIL,
                          arguments: lastComic.comicId);
                    }
                  },
                  icon: const Icon(
                    Icons.play_circle_outline,
                    color: Colors.white,
                    size: 20,
                  ),
                  label: const Text(
                    'Lanjutkan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black26,
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
      ),
    );
  }

  Widget _buildPopularGrid(BuildContext context) {
    final popularComics = controller.popularKomikData.value.popularManga;

    return Container(
      height: 180,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
    final terbaruComics = controller.comicData.value.comicsList
        .where((comic) => comic.status!.toLowerCase() == 'ongoing')
        .toList();

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 12,
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

  Widget _buildKomikGrid(BuildContext context) {
    final completedComics = controller.comicData.value.comicsList
        .where((comic) => comic.status!.toLowerCase() == 'completed')
        .toList();

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: completedComics.length,
      itemBuilder: (context, index) {
        final comic = completedComics[index];
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
