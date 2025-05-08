class ChapterData {
  final DataChapter chapter;
  final String source;

  ChapterData({
    required this.chapter,
    required this.source,
  });

  factory ChapterData.fromJson(Map<String, dynamic> json) => ChapterData(
        chapter: DataChapter.fromJson(json["chapter"] ?? {}),
        source: json["source"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "chapter": chapter.toJson(),
        "source": source,
      };
}

class DataChapter {
  final String chapterId;
  final List<String> images;
  final String previousChapter;
  final String? nextChapter;
  final List<ChapterElement> chapters;

  DataChapter({
    required this.chapterId,
    required this.images,
    required this.previousChapter,
    this.nextChapter,
    required this.chapters,
  });

  factory DataChapter.fromJson(Map<String, dynamic> json) => DataChapter(
        chapterId: json["chapterId"] ?? "",
        images: json["images"] != null
            ? List<String>.from(json["images"].map((x) => x.toString()))
            : [],
        previousChapter: json["previousChapter"] ?? "",
        nextChapter: json["nextChapter"]?.toString(),
        chapters: json["chapters"] != null
            ? List<ChapterElement>.from(
                json["chapters"].map((x) => ChapterElement.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "chapterId": chapterId,
        "images": List<dynamic>.from(images.map((x) => x)),
        "previousChapter": previousChapter,
        "nextChapter": nextChapter,
        "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
      };
}

class ChapterElement {
  final String chapterId;
  final String title;
  final String url;

  ChapterElement({
    required this.chapterId,
    required this.title,
    required this.url,
  });

  factory ChapterElement.fromJson(Map<String, dynamic> json) => ChapterElement(
        chapterId: json["chapterId"] ?? "",
        title: json["title"] ?? "",
        url: json["url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "chapterId": chapterId,
        "title": title,
        "url": url,
      };
}
