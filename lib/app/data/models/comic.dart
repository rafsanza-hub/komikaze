class ComicData {
  final List<ComicsList> comicsList;
  final int page;
  final List<dynamic> genres;
  final String status;
  final String type;
  final String orderby;
  final String source;

  ComicData({
    required this.comicsList,
    required this.page,
    required this.genres,
    required this.status,
    required this.type,
    required this.orderby,
    required this.source,
  });

  factory ComicData.fromJson(Map<String, dynamic> json) => ComicData(
        comicsList: List<ComicsList>.from(
            json["comicsList"].map((x) => ComicsList.fromJson(x))),
        page: json["page"],
        genres: List<dynamic>.from(json["genres"].map((x) => x)),
        status: json["status"],
        type: json["type"],
        orderby: json["orderby"],
        source: json["source"],
      );

  Map<String, dynamic> toJson() => {
        "comicsList": List<dynamic>.from(comicsList.map((x) => x.toJson())),
        "page": page,
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "status": status,
        "type": type,
        "orderby": orderby,
        "source": source,
      };
}

class ComicsList {
  final String comicId;
  final String title;
  final String link;
  final String image;
  final String type;
  final String chapter;
  final String rating;
  final String status;

  ComicsList({
    required this.comicId,
    required this.title,
    required this.link,
    required this.image,
    required this.type,
    required this.chapter,
    required this.rating,
    required this.status,
  });

  factory ComicsList.fromJson(Map<String, dynamic> json) => ComicsList(
        comicId: json["comicId"],
        title: json["title"],
        link: json["link"],
        image: json["image"],
        type: json["type"],
        chapter: json["chapter"],
        rating: json["rating"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "comicId": comicId,
        "title": title,
        "link": link,
        "image": image,
        "type": type,
        "chapter": chapter,
        "rating": rating,
        "status": status,
      };
}
