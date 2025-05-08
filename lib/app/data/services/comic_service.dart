import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:komikaze/app/data/models/comic.dart';
import 'package:komikaze/app/data/models/comic_detail.dart';

class ComicService {
  Future<ComicData> fetchComics() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:3000/api/comics'));
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
      final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/comics/$comicId'));
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
}
