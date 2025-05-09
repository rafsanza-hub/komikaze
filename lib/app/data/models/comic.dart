class ComicData {
  final List<ComicsList> comicsList;
  final Pagination? pagination;
  final String source;
  final int? page;
  final List<dynamic>? genres;
  final String? status;
  final String? type;
  final String? orderby;

  ComicData({
    required this.comicsList,
    this.pagination,
    required this.source,
    this.page,
    this.genres,
    this.status,
    this.type,
    this.orderby,
  });

  factory ComicData.fromJson(Map<String, dynamic> json) => ComicData(
        comicsList: List<ComicsList>.from(
            json["comicsList"].map((x) => ComicsList.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
        source: json["source"] ?? '',
        page: json["page"] ?? 1,
        genres: json["genres"] == null
            ? []
            : List<dynamic>.from(json["genres"]!.map((x) => x)),
        status: json["status"] ?? '',
        type: json["type"] ?? '',
        orderby: json["orderby"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "comicsList": List<dynamic>.from(comicsList.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
        "source": source,
        "page": page,
        "genres":
            genres == null ? [] : List<dynamic>.from(genres!.map((x) => x)),
        "status": status,
        "type": type,
        "orderby": orderby,
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
  final String? status;

  ComicsList({
    required this.comicId,
    required this.title,
    required this.link,
    required this.image,
    required this.type,
    required this.chapter,
    required this.rating,
     this.status,
  });

  factory ComicsList.fromJson(Map<String, dynamic> json) => ComicsList(
        comicId: json["comicId"],
        title: json["title"],
        link: json["link"],
        image: json["image"],
        type: json["type"],
        chapter: json["chapter"],
        rating: json["rating"],
        status: json["status"] ?? '',
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

class Pagination {
  final int currentPage;
  final dynamic prevPage;
  final int nextPage;

  Pagination({
    required this.currentPage,
    required this.prevPage,
    required this.nextPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["currentPage"],
        prevPage: json["prevPage"] ?? 1,
        nextPage: json["nextPage"] ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "currentPage": currentPage,
        "prevPage": prevPage,
        "nextPage": nextPage,
      };
}
