class ComicDetailData {
  final ComicDetail comicDetail;
  final String source;

  ComicDetailData({
    required this.comicDetail,
    required this.source,
  });

  factory ComicDetailData.fromJson(Map<String, dynamic> json) =>
      ComicDetailData(
        comicDetail: ComicDetail.fromJson(json["comicDetail"] ?? {}),
        source: json["source"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "comicDetail": comicDetail.toJson(),
        "source": source,
      };
}

class ComicDetail {
  final String comicId;
  final String coverImage;
  final String title;
  final String nativeTitle;
  final List<String> genres;
  final String releaseYear;
  final String author;
  final String status;
  final String type;
  final String totalChapters;
  final String updatedOn;
  final String rating;
  final String synopsis;
  final List<Chapter> chapters;

  ComicDetail({
    required this.comicId,
    required this.coverImage,
    required this.title,
    required this.nativeTitle,
    required this.genres,
    required this.releaseYear,
    required this.author,
    required this.status,
    required this.type,
    required this.totalChapters,
    required this.updatedOn,
    required this.rating,
    required this.synopsis,
    required this.chapters,
  });

  factory ComicDetail.fromJson(Map<String, dynamic> json) => ComicDetail(
        comicId: json["comicId"] ?? "",
        coverImage: json["coverImage"] ?? "",
        title: json["title"] ?? "",
        nativeTitle: json["nativeTitle"] ?? "",
        genres: json["genres"] != null
            ? List<String>.from(json["genres"].map((x) => x.toString()))
            : [],
        releaseYear: json["releaseYear"] ?? "",
        author: json["author"] ?? "",
        status: json["status"] ?? "",
        type: json["type"] ?? "",
        totalChapters: json["totalChapters"] ?? "0",
        updatedOn: json["updatedOn"] ?? "",
        rating: json["rating"] ?? "0.0",
        synopsis: json["synopsis"] ?? "",
        chapters: json["chapters"] != null
            ? List<Chapter>.from(
                json["chapters"].map((x) => Chapter.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "comicId": comicId,
        "coverImage": coverImage,
        "title": title,
        "nativeTitle": nativeTitle,
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "releaseYear": releaseYear,
        "author": author,
        "status": status,
        "type": type,
        "totalChapters": totalChapters,
        "updatedOn": updatedOn,
        "rating": rating,
        "synopsis": synopsis,
        "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
      };
}

class Chapter {
  String chapterId;
  final String title;
  final String link;
  final String releaseTime;

  Chapter({
    required this.chapterId,
    required this.title,
    required this.link,
    required this.releaseTime,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        chapterId: json["chapterId"] ?? "",
        title: json["title"] ?? "",
        link: json["link"] ?? "",
        releaseTime: json["releaseTime"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "chapterId": chapterId,
        "title": title,
        "link": link,
        "releaseTime": releaseTime,
      };
}
