import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:komikaze/app/modules/comic_detail/controllers/comic_detail_controller.dart';
import 'package:komikaze/app/routes/app_pages.dart';

class ComicDetailView extends GetView<ComicDetailController> {
  const ComicDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil comicId dari argumen navigasi
    final comicId = Get.arguments as String;
    controller.fetchComicDetail(comicId);

    return Scaffold(
      backgroundColor: const Color(0xff121012),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Comic Detail'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final comic = controller.comicDetailData.value.comicDetail;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover Image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: comic.coverImage,
                    width: 200,
                    height: 300,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Title
              Text(
                comic.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                comic.nativeTitle,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              // Genres
              Wrap(
                spacing: 8,
                children: comic.genres
                    .map((genre) => Chip(
                          label: Text(genre),
                          backgroundColor: const Color(0xff382C3E),
                          labelStyle: const TextStyle(color: Colors.white54),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 8),
              // Metadata
              Text(
                'Author: ${comic.author}',
                style: const TextStyle(color: Colors.white70),
              ),
              Text(
                'Status: ${comic.status}',
                style: const TextStyle(color: Colors.white70),
              ),
              Text(
                'Type: ${comic.type}',
                style: const TextStyle(color: Colors.white70),
              ),
              Text(
                'Release Year: ${comic.releaseYear}',
                style: const TextStyle(color: Colors.white70),
              ),
              Text(
                'Total Chapters: ${comic.totalChapters}',
                style: const TextStyle(color: Colors.white70),
              ),
              Text(
                'Rating: ${comic.rating}',
                style: const TextStyle(color: Colors.white70),
              ),
              Text(
                'Updated On: ${comic.updatedOn}',
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              // Synopsis
              const Text(
                'Synopsis',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                comic.synopsis,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              // Chapters
              const Text(
                'Chapters',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: comic.chapters.length,
                itemBuilder: (context, index) {
                  final chapter = comic.chapters[index];
                  return ListTile(
                    title: Text(
                      chapter.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      chapter.releaseTime,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    onTap: () {
                      Get.toNamed(Routes.CHAPTER, arguments: {
                        'comicId': comic.comicId,
                        'chapterId': chapter.chapterId,
                      });
                    },
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
