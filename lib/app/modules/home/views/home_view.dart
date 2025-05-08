import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Hi, Rafsan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const KomikCardsSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class KomikCardsSection extends StatelessWidget {
  const KomikCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHistorySection(context),
        _buildSectionTitle(context, "Ongoing"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: _buildOngoingGrid(context),
        ),
        _buildSectionTitle(context, "Genre pilihan"),
        _buildGenreChips(context),
        _buildSectionTitle(context, "Completed"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: _buildKomikGrid(context),
        ),
      ],
    );
  }

  Widget _buildHistorySection(BuildContext context) {
    return Container(
      height: 140,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: NetworkImage('https://via.placeholder.com/400x200'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "Terakhir dilihat",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Judul Komik Terakhir",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.play_circle_outline,
                    color: Colors.white,
                    size: 20,
                  ),
                  label: const Text(
                    'Lanjutkan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black26,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOngoingGrid(BuildContext context) {
    final dummyKomikList = List.generate(
        6,
        (index) => Komik(
              komikId: "$index",
              title: "Komik Ongoing ${index + 1}",
              poster: "https://via.placeholder.com/150x200",
              rating: "0.0",
              episode: "12",
              type: "TV",
              synopsis: "Synopsis placeholder",
              genre: ["Action", "Adventure"],
              status: "Ongoing",
              totalEpisode: "24",
            ));

    return Container(
      height: 180,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: dummyKomikList.length,
        itemBuilder: (context, index) {
          return Container(
            width: (MediaQuery.of(context).size.width - 48) / 3,
            margin: const EdgeInsets.only(right: 8),
            child: GestureDetector(
                onTap: () {},
                child: CustomCardNormal(
                  title: "Naruto Shippuden",
                  episodeCount: "24 Eps",
                  imageUrl: "https://example.com/naruto-poster.jpg",
                )),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (title == "Completed" || title == "Ongoing")
            GestureDetector(
              onTap: () {},
              child: const Text(
                "See all",
                style: TextStyle(
                  color: kButtonColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          if (title == "History")
            GestureDetector(
              onTap: () {},
              child: const Text(
                "See all",
                style: TextStyle(
                  color: kButtonColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildKomikGrid(BuildContext context) {
    final dummyKomikList = List.generate(
        9,
        (index) => Komik(
              komikId: "$index",
              title: "Komik Completed ${index + 1}",
              poster: "https://via.placeholder.com/150x200",
              rating: "0.0",
              episode: "12",
              type: "TV",
              synopsis: "Synopsis placeholder",
              genre: ["Action", "Adventure"],
              status: "Completed",
              totalEpisode: "24",
            ));

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 12,
      ),
      itemCount: dummyKomikList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {},
            child: CustomCardNormal(
              title: "Naruto Shippuden",
              episodeCount: "24 Eps",
              imageUrl: "https://example.com/naruto-poster.jpg",
            ));
      },
    );
  }

  Widget _buildGenreChips(BuildContext context) {
    final dummyGenres = [
      {"title": "Action", "genreId": "1"},
      {"title": "Adventure", "genreId": "2"},
      {"title": "Comedy", "genreId": "3"},
      {"title": "Drama", "genreId": "4"},
      {"title": "Fantasy", "genreId": "5"},
    ];

    return Container(
      height: 36,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: dummyGenres.length,
        itemBuilder: (context, index) {
          final genre = dummyGenres[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ActionChip(
              backgroundColor: kSearchbarColor,
              side: BorderSide.none,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              label: Text(
                genre["title"]!,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),
              onPressed: () {
                // Navigation removed as it would require BLoC
              },
            ),
          );
        },
      ),
    );
  }
}

const kBackgroundColor = Color(0xff121012);
const kButtonColor = Color.fromARGB(255, 89, 54, 133);
const kSearchbarColor = Color(0xff382C3E);

// Class dasar untuk properti umum komik
class Komik {
  final String komikId;
  final String title;
  final String poster;
  final String rating;
  final String episode;
  final String type;
  final String synopsis;
  final List<String> genre;
  final String status;
  final String totalEpisode;

  // Constructor dengan nilai default untuk static UI
  const Komik({
    this.komikId = "1",
    this.title = "Judul Komik",
    this.poster = "https://via.placeholder.com/150x200",
    this.rating = "8.5",
    this.episode = "12",
    this.type = "TV",
    this.synopsis = "Ini adalah sinopsis contoh untuk komik statis.",
    this.genre = const ["Action", "Adventure"],
    this.status = "Ongoing",
    this.totalEpisode = "24",
  });

  // Method untuk membuat list komik dummy
  static List<Komik> dummyList({int count = 6}) {
    return List.generate(
        count,
        (index) => Komik(
              komikId: "${index + 1}",
              title: "Komik ${index + 1}",
              poster:
                  "https://via.placeholder.com/150x200?text=Komik+${index + 1}",
              episode: "${index + 12}",
              rating: (8.0 + (index * 0.1)).toStringAsFixed(1),
            ));
  }
}

// Class untuk komik yang masih ongoing

class GenreResponse {
  final int statusCode;
  final String statusMessage;
  final String message;
  final bool ok;
  final GenreData data;
  final dynamic pagination;

  GenreResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.message,
    required this.ok,
    required this.data,
    this.pagination,
  });

  factory GenreResponse.fromJson(Map<String, dynamic> json) {
    return GenreResponse(
      statusCode: json['statusCode'],
      statusMessage: json['statusMessage'],
      message: json['message'],
      ok: json['ok'],
      data: GenreData.fromJson(json['data']),
      pagination: json['pagination'],
    );
  }
}

class GenreData {
  final List<Genre> genreList;

  GenreData({
    required this.genreList,
  });

  factory GenreData.fromJson(Map<String, dynamic> json) {
    return GenreData(
      genreList: (json['genreList'] as List)
          .map((item) => Genre.fromJson(item))
          .toList(),
    );
  }
}

class Genre {
  final String title;
  final String genreId;
  final String href;
  final String otakudesuUrl;

  Genre({
    required this.title,
    required this.genreId,
    required this.href,
    required this.otakudesuUrl,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      title: json['title'],
      genreId: json['genreId'],
      href: json['href'],
      otakudesuUrl: json['otakudesuUrl'],
    );
  }
}

class CustomCardNormal extends StatelessWidget {
  final String title;
  final String episodeCount;
  final String imageUrl;

  const CustomCardNormal({
    super.key,
    this.title = "Komik Title",
    this.episodeCount = "12 Eps",
    this.imageUrl = "https://via.placeholder.com/150x200",
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image Container
        Container(
          height: 180,
          width: 120,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.6),
                Colors.black.withOpacity(0.8),
              ],
              stops: const [0.5, 0.8, 1.0],
            ),
          ),
        ),

        // Episode Count Badge
        Positioned(
          left: 7,
          top: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              episodeCount,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // Komik Title
        Positioned(
          left: 4,
          right: 4,
          bottom: 8,
          child: Text(
            title,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(0, 1),
                  blurRadius: 3.0,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
