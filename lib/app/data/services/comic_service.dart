import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:komikaze/app/core/config/config.dart';
import 'package:komikaze/app/data/models/chapter.dart';
import 'package:komikaze/app/data/models/comic.dart';
import 'package:komikaze/app/data/models/comic_detail.dart';
import 'package:komikaze/app/data/models/popular_comic.dart';

class ComicService {
  Future<ComicData> fetchComics() async {
    try {
      final response =
          await http.get(Uri.parse('${AppConfig.baseUrl}/comics'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ComicData.fromJson(jsonData['data']);
      } else {
        throw Exception('Failed to fetch comics: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching comics: $e');
    }
  }

  Future<ComicDetailData> fetchComicDetail(String comicId) async {
    print('comic id: $comicId');
    try {
      final response =
          await http.get(Uri.parse('${AppConfig.baseUrl}/comics/$comicId'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ComicDetailData.fromJson(jsonData['data']);
      } else {
        throw Exception('Failed to fetch comic detail: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching comic detail: $e');
    }
  }

  Future<ChapterData> fetchChapter(String chapterId) async {
    try {
      final response = await http
          .get(Uri.parse('${AppConfig.baseUrl}/chapters/$chapterId'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ChapterData.fromJson(jsonData['data']);
      } else {
        throw Exception('Failed to fetch chapter: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching chapter: $e');
    }
  }

  Future<PopularKomikData> fetchPopularComics() async {
    try {
      final response =
          await http.get(Uri.parse('${AppConfig.baseUrl}/popular-manga'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print('popular komik: ${jsonData['data']}');
        return PopularKomikData.fromJson(jsonData['data']);
      } else {
        throw Exception(
            'Failed to fetch popular comics: ${response.statusCode}');
      }
    } catch (e) {
      print('popular komik: $e');
      throw Exception('Error fetching popular comics: $e');
    }
  }

  Future<ComicData> searchComics(String query) async {
    try {
      final response = await http.get(
        Uri.parse('${AppConfig.baseUrl}/search?query=$query'),
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ComicData.fromJson(jsonData['data']);
      } else {
        throw Exception(
            'Failed to fetch search results: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching search results: $e');
    }
  }
}
