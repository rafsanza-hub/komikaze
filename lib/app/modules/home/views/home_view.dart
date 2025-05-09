import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:komikaze/app/modules/home/controllers/home_controller.dart';
import 'package:komikaze/app/routes/app_pages.dart';

const kBackgroundColor = Color(0xff121012);
const kButtonColor = Color.fromARGB(255, 89, 54, 133);
const kSearchbarColor = Color(0xff382C3E);

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Hi, Rafsan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        // Implement search functionality
                        Get.toNamed(Routes.COMIC_DETAIL);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const KomikCardsSection(),
            ],
          ),
        ),
      ),
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
                ? DecorationImage(
                    image: NetworkImage(lastComic.image),
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
                  maxLines: 2,
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: popularComics.length,
        itemBuilder: (context, index) {
          final comic = popularComics[index];
          return Container(
            width: (MediaQuery.of(context).size.width - 48) / 3,
            margin: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.COMIC_DETAIL, arguments: comic.comicId);
              },
              child: CustomCardNormal(
                title: comic.title,
                episodeCount: 'Rank ${comic.rank}',
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
        .where((comic) => comic.status.toLowerCase() == 'ongoing')
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
            episodeCount: comic.chapter,
            imageUrl: comic.image,
          ),
        );
      },
    );
  }

  Widget _buildKomikGrid(BuildContext context) {
    final completedComics = controller.comicData.value.comicsList
        .where((comic) => comic.status.toLowerCase() == 'completed')
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
      itemCount: completedComics.length,
      itemBuilder: (context, index) {
        final comic = completedComics[index];
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
                // Navigate to genre-specific comics using genre.link
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

class CustomCardNormal extends StatelessWidget {
  final String title;
  final String episodeCount;
  final String imageUrl;

  const CustomCardNormal({
    super.key,
    required this.title,
    required this.episodeCount,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 180,
          width: 120,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: CachedNetworkImageProvider(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.6),
                Colors.black.withOpacity(0.8),
              ],
              stops: const [0.5, 0.8, 1.0],
            ),
          ),
        ),
        Positioned(
          left: 7,
          top: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              episodeCount,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Positioned(
          left: 4,
          right: 4,
          bottom: 8,
          child: Text(
            title,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(0, 1),
                  blurRadius: 3.0,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
