class GenreData {
    final List<Genre> genres;
    final String source;

    GenreData({
        required this.genres,
        required this.source,
    });

    factory GenreData.fromJson(Map<String, dynamic> json) => GenreData(
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        source: json["source"],
    );

    Map<String, dynamic> toJson() => {
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "source": source,
    };
}

class Genre {
    final String name;
    final int seriesCount;
    final String link;

    Genre({
        required this.name,
        required this.seriesCount,
        required this.link,
    });

    factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        name: json["name"],
        seriesCount: json["seriesCount"],
        link: json["link"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "seriesCount": seriesCount,
        "link": link,
    };
}
