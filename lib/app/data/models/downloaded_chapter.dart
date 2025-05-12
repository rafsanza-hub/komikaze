class DownloadedChapter {
  final String comicId;
  final String chapterId;
  final String comicTitle;
  final String chapterTitle;
  final String coverImage;
  final List<String> localImagePaths;
  final DateTime downloadedAt;

  DownloadedChapter({
    required this.comicId,
    required this.chapterId,
    required this.comicTitle,
    required this.chapterTitle,
    required this.coverImage,
    required this.localImagePaths,
    required this.downloadedAt,
  });

  factory DownloadedChapter.fromJson(Map<String, dynamic> json) => DownloadedChapter(
        comicId: json['comicId'] ?? '',
        chapterId: json['chapterId'] ?? '',
        comicTitle: json['comicTitle'] ?? '',
        chapterTitle: json['chapterTitle'] ?? '',
        coverImage: json['coverImage'] ?? '',
        localImagePaths: List<String>.from(json['localImagePaths'] ?? []),
        downloadedAt: DateTime.parse(json['downloadedAt'] ?? DateTime.now().toIso8601String()),
      );

  Map<String, dynamic> toJson() => {
        'comicId': comicId,
        'chapterId': chapterId,
        'comicTitle': comicTitle,
        'chapterTitle': chapterTitle,
        'coverImage': coverImage,
        'localImagePaths': localImagePaths,
        'downloadedAt': downloadedAt.toIso8601String(),
      };
}