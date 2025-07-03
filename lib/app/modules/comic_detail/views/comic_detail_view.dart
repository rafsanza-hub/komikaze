import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komikaze/app/core/constants/colors.dart';
import 'package:komikaze/app/data/models/bookmark.dart';
import 'package:komikaze/app/data/models/comic_detail.dart';
import 'package:komikaze/app/data/models/history.dart';
import 'package:komikaze/app/modules/bookmark/controllers/bookmark_controller.dart';
import 'package:komikaze/app/modules/comic_detail/controllers/comic_detail_controller.dart';
import 'package:komikaze/app/modules/history/controllers/history_controller.dart';
import 'package:komikaze/app/routes/app_pages.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';

class ComicDetailView extends GetView<ComicDetailController> {
  const ComicDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Stack(
            children: [
              const ComicDetailSkeletonLoader(),
              _buildCloseButton(context),
            ],
          );
        }

        final comic = controller.comicDetailData.value.comicDetail;
        return _buildContent(context, comic, controller);
      }),
    );
  }

  Widget _buildContent(BuildContext context, ComicDetail comic,
      ComicDetailController controller) {
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
                    _buildChapterNavigationButtons(context, comic),
                    const SizedBox(height: 10),
                    _buildChaptersList(context, comic, comic.chapters),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
        _buildCloseButton(context),
        _buildBookmarkButton(context, comic),
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
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: AppColors.searchBar,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                      color: AppColors.primary,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.searchBar,
                  child: const Center(
                    child: Icon(
                      Icons.broken_image_rounded,
                      color: Colors.white54,
                      size: 64,
                    ),
                  ),
                );
              },
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
                    AppColors.background.withValues(alpha: 0.8),
                    AppColors.background,
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
                backgroundColor: AppColors.searchBar,
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
          moreStyle: const TextStyle(color: AppColors.primary),
          lessStyle: const TextStyle(color: AppColors.primary),
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
        _buildInfoItem('author'.tr, comic.author),
        _buildInfoItem('released'.tr, comic.releaseYear),
        _buildInfoItem('status'.tr, comic.status),
        _buildInfoItem('type'.tr, comic.type),
        _buildInfoItem('rating'.tr, comic.rating),
        _buildInfoItem('updated'.tr, comic.updatedOn),
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
      BuildContext context, ComicDetail comic, List<Chapter> chapters) {
    final TextEditingController searchController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'chapters'.tr,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: searchController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'search_chapters'.tr,
            hintStyle: const TextStyle(color: Colors.white54),
            border: InputBorder.none,
            icon: const Icon(Icons.search, color: Colors.white54),
          ),
          onChanged: (value) {
            controller.filterChapters(value);
          },
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
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemCount: filteredChapters.length,
            itemBuilder: (context, index) {
              final chapter = filteredChapters[index];
              return Card(
                margin: EdgeInsets.zero,
                elevation: 0,
                color: AppColors.searchBar,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    _navigateToChapter(
                        context, comic, chapter.chapterId, chapter.title);
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
                                chapter.releaseTime,
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Obx(() {
                          final progress =
                              controller.downloadingChapters[chapter.chapterId];
                          if (progress != null) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 9),
                              child: SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: CircularProgressIndicator(
                                      value: progress)),
                            );
                          }
                          return IconButton(
                            icon: Icon(
                              controller.isChapterDownloaded(chapter.chapterId)
                                  ? Icons.download_done
                                  : Icons.download,
                              color: Colors.white54,
                            ),
                            onPressed: () {
                              if (!controller
                                  .isChapterDownloaded(chapter.chapterId)) {
                                controller.downloadChapter(
                                  chapter,
                                  comic.comicId,
                                  comic.title,
                                  comic.coverImage,
                                );
                              } else {
                                Get.snackbar(
                                    'Info', 'chapter_already_downloaded'.tr);
                              }
                            },
                          );
                        }),
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

  Widget _buildChapterNavigationButtons(
      BuildContext context, ComicDetail comic) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              if (comic.chapters.isNotEmpty) {
                _navigateToChapter(
                  context,
                  comic,
                  comic.chapters.last.chapterId,
                  comic.chapters.last.title,
                );
              }
            },
            child: Text(
              'first_chapter'.tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              if (comic.chapters.isNotEmpty) {
                _navigateToChapter(
                  context,
                  comic,
                  comic.chapters.first.chapterId,
                  comic.chapters.first.title,
                );
              }
            },
            child: Text(
              'last_chapter'.tr,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Positioned(
      top: 45,
      left: 20,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black38,
        ),
        child: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.close_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildBookmarkButton(BuildContext context, ComicDetail comic) {
    final bookmarkController = Get.find<BookmarkController>();
    final isBookmarked =
        bookmarkController.bookmarks.any((b) => b.comicId == comic.comicId);

    return Positioned(
      top: 45,
      right: 20,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black38,
        ),
        child: IconButton(
          onPressed: () {
            if (isBookmarked) {
              bookmarkController.deleteBookmark(comic.comicId);
              Get.snackbar(
                'Bookmark Removed',
                '${comic.title} removed from bookmarks',
                backgroundColor: AppColors.searchBar,
                colorText: Colors.white,
              );
            } else {
              final bookmark = BookmarkItem(
                comicId: comic.comicId,
                title: comic.title,
                coverImage: comic.coverImage,
                type: comic.type,
              );
              bookmarkController.addBookmark(bookmark);
              Get.snackbar(
                'Bookmark Added',
                '${comic.title} added to bookmarks',
                backgroundColor: AppColors.searchBar,
                colorText: Colors.white,
              );
            }
          },
          icon: Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            color: isBookmarked ? AppColors.primary : Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  void _navigateToChapter(BuildContext context, ComicDetail comic,
      String chapterId, String chapterTitle) {
    HistoryItem historyItem = HistoryItem(
      comicId: comic.comicId,
      chapterId: chapterId,
      chapterTitle: chapterTitle,
      coverImage: comic.coverImage,
      title: comic.title,
      lastRead: DateTime.now(),
      type: comic.type,
    );
    Get.find<HistoryController>().addHistory(historyItem);
    Get.toNamed(Routes.CHAPTER, arguments: {
      'chapterId': chapterId,
      'comicId': comic.comicId,
      'comicTitle': comic.title,
    });
  }
}

class ComicDetailSkeletonLoader extends StatelessWidget {
  const ComicDetailSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Shimmer.fromColors(
        direction: ShimmerDirection.ltr,
        baseColor: AppColors.searchBar,
        highlightColor: Color(0xff5B4563),
        child: Column(
          children: [
            _buildCoverImageSkeleton(),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleSkeleton(),
                  const SizedBox(height: 10),
                  _buildGenreChipsSkeleton(),
                  const SizedBox(height: 10),
                  _buildSynopsisSkeleton(),
                  const SizedBox(height: 10),
                  _buildInfoSectionSkeleton(),
                  const SizedBox(height: 10),
                  _buildChapterButtonsSkeleton(),
                  const SizedBox(height: 10),
                  _buildChaptersListSkeleton(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverImageSkeleton() {
    return Container(
      width: double.infinity,
      height: 480,
      color: AppColors.searchBar,
    );
  }

  Widget _buildTitleSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 300,
          height: 30,
          decoration: BoxDecoration(
            color: AppColors.searchBar,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 150,
          height: 15,
          decoration: BoxDecoration(
            color: AppColors.searchBar,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }

  Widget _buildGenreChipsSkeleton() {
    return SizedBox(
      height: 36,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Row(
            children: [
              SizedBox(width: index == 0 ? 0 : 8),
              Container(
                width: 70,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.searchBar,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSynopsisSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 12,
          decoration: BoxDecoration(
            color: AppColors.searchBar,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 12,
          decoration: BoxDecoration(
            color: AppColors.searchBar,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 200,
          height: 12,
          decoration: BoxDecoration(
            color: AppColors.searchBar,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSectionSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        6,
        (index) => Column(
          children: [
            const SizedBox(height: 8),
            Container(
              width: index % 2 == 0 ? 170 : 180,
              height: 14,
              decoration: BoxDecoration(
                color: AppColors.searchBar,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChapterButtonsSkeleton() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.searchBar,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.searchBar,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChaptersListSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.searchBar,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.searchBar,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 10),
        ...List.generate(
          10,
          (index) => Column(
            children: [
              Container(
                height: 70,
                decoration: BoxDecoration(
                  color: AppColors.searchBar,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}
