class PopularKomikData {
  final List<PopularKomik> popularManga;
  final String source;

  PopularKomikData({
    required this.popularManga,
    required this.source,
  });

  factory PopularKomikData.fromJson(Map<String, dynamic> json) =>
      PopularKomikData(
        popularManga: json["popularManga"] != null
            ? List<PopularKomik>.from(
                json["popularManga"].map((x) => PopularKomik.fromJson(x)))
            : [],
        source: json["source"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "popularManga": List<dynamic>.from(popularManga.map((x) => x.toJson())),
        "source": source,
      };
}

class PopularKomik {
  final String comicId;
  final int rank;
  final String title;
  final String link;
  final String image;
  final List<String> genres;
  final int? year;

  PopularKomik({
    required this.comicId,
    required this.rank,
    required this.title,
    required this.link,
    required this.image,
    required this.genres,
    this.year,
  });

  factory PopularKomik.fromJson(Map<String, dynamic> json) => PopularKomik(
        comicId: json["comicId"] ?? "",
        rank: int.tryParse(json["rank"]?.toString() ?? "0") ?? 0,
        title: json["title"] ?? "",
        link: json["link"] ?? "",
        image: json["image"] ?? "",
        genres: json["genres"] != null
            ? List<String>.from(json["genres"].map((x) => x.toString()))
            : [],
        year: int.tryParse(json["year"]?.toString() ?? ""),
      );

  Map<String, dynamic> toJson() => {
        "comicId": comicId,
        "rank": rank,
        "title": title,
        "link": link,
        "image": image,
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "year": year,
      };
}
