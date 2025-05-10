import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komikaze/app/data/models/comic_detail.dart';
import 'package:komikaze/app/modules/comic_detail/controllers/comic_detail_controller.dart';
import 'package:komikaze/app/routes/app_pages.dart';
import 'package:readmore/readmore.dart';

class ComicDetailView extends GetView<ComicDetailController> {
  const ComicDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final comicId = Get.arguments as String;
    controller.fetchComicDetail(comicId);
    // final HistoryController historyController = Get.put(HistoryController());

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // if (controller.errorMessage.value.isNotEmpty) {
        //   return Center(child: Text(controller.errorMessage.value));
        // }

        final comic = controller.comicDetailData.value.comicDetail;
        return _buildContent(
          context,
          comic,
          controller, /* historyController */
        );
      }),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ComicDetail comic,
    ComicDetailController controller,
    // HistoryController historyController,
  ) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              _buildHeroImage(comic.coverImage),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleSection(comic),
                    const SizedBox(height: 10),
                    _buildGenreChips(context, comic.genres),
                    const SizedBox(height: 10),
                    _buildSynopsis(comic),
                    const SizedBox(height: 10),
                    _buildInfoSection(comic),
                    const SizedBox(height: 10),
                    _buildChaptersList(
                        context, comic.chapters /* historyController */),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
        _buildCloseButton(context),
        _buildReadButton(
            context, comic.chapters.last.chapterId /* historyController */),
      ],
    );
  }

  Widget _buildHeroImage(String imageUrl) {
    return SizedBox(
      width: double.infinity,
      height: 500,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
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
        ],
      ),
    );
  }

  Widget _buildTitleSection(ComicDetail comic) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comic.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (comic.nativeTitle != 'No Native Title')
                Text(
                  comic.nativeTitle,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGenreChips(BuildContext context, List<String> genres) {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: genres.length,
        itemBuilder: (context, index) {
          final genre = genres[index];
          return Row(
            children: [
              SizedBox(width: index == 0 ? 0 : 8),
              ActionChip(
                backgroundColor: kSearchbarColor,
                side: BorderSide.none,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                label: Text(
                  genre,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
                onPressed: () {
                  Get.toNamed(Routes.GENRE_DETAIL, arguments: genre);
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSynopsis(ComicDetail comic) {
    return Column(
      children: [
        ReadMoreText(
          comic.synopsis,
          trimLines: 3,
          trimMode: TrimMode.Line,
          moreStyle: const TextStyle(color: kButtonColor),
          lessStyle: const TextStyle(color: kButtonColor),
          style: const TextStyle(
            color: Colors.white70,
            height: 1.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(ComicDetail comic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoItem('Author', comic.author),
        _buildInfoItem('Released', comic.releaseYear),
        _buildInfoItem('Status', comic.status),
        _buildInfoItem('Type', comic.type),
        _buildInfoItem('Rating', comic.rating),
        _buildInfoItem('Updated', comic.updatedOn),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(
          '$label: $value',
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildChaptersList(
    BuildContext context,
    List<Chapter> chapters,
  ) {
    final TextEditingController searchController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Chapters',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        // Add search bar for chapters
        Container(
          decoration: BoxDecoration(
            color: kSearchbarColor,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: searchController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Search chapters...',
              hintStyle: TextStyle(color: Colors.white54),
              border: InputBorder.none,
              icon: Icon(Icons.search, color: Colors.white54),
            ),
            onChanged: (value) {
              controller.filterChapters(value);
            },
          ),
        ),
        const SizedBox(height: 10),
        Obx(() {
          final filteredChapters = controller.filteredChapters.isNotEmpty
              ? controller.filteredChapters
              : chapters;

          return ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
            itemCount: filteredChapters.length,
            itemBuilder: (context, index) {
              final chapter = filteredChapters[index];
              return Card(
                margin: EdgeInsets.zero,
                elevation: 0, // Remove shadow
                color: kSearchbarColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    _navigateToChapter(context, chapter.chapterId);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chapter.title
                                    .replaceAll(RegExp(r'\s+'), ' ')
                                    .trim(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${chapter.releaseTime}',
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.white54,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Positioned(
      top: 60,
      left: 20,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black38,
        ),
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.close_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildReadButton(
    BuildContext context,
    String chapterId,
    // HistoryController historyController,
  ) {
    return Positioned(
      left: 30,
      right: 30,
      bottom: 30,
      child: GestureDetector(
        onTap: () {
          // _addToHistory(historyController, chapterId);
          _navigateToChapter(context, chapterId);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            color: kButtonColor,
            alignment: Alignment.center,
            height: 68,
            child: const Text(
              "Read Now",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToChapter(BuildContext context, String chapterId) {
    Get.toNamed(Routes.CHAPTER, arguments: {'chapterId': chapterId});
  }
}

const kBackgroundColor = Color(0xff121012);
const kButtonColor = Color.fromARGB(255, 89, 54, 133);
const kSearchbarColor = Color(0xff382C3E);
