import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:komikaze/app/core/config/config.dart';
import 'package:komikaze/app/data/models/comic.dart';
import 'package:komikaze/app/data/models/genre.dart';

class GenreService extends GetxService {
  Future<GenreData> fetchGenres() async {
    try {
      final response =
          await http.get(Uri.parse('${AppConfig.baseUrl}/genres'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return GenreData.fromJson(jsonData['data']);
      } else {
        throw Exception('Failed to fetch genres: ${response.statusCode}');
      }
    } catch (e) {
      print('errorrr' + e.toString());

      throw Exception('Error fetching genres: $e');
    }
  }

  Future<ComicData> fetchGenreDetail(String genre, {int page = 1}) async {
    try {
      final response = await http
          .get(Uri.parse('${AppConfig.baseUrl}/genres/$genre?page=$page'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print('genre rororo:' + jsonData['data'].toString());
        return ComicData.fromJson(jsonData['data']);
      } else {
        throw Exception('Failed to fetch comics: ${response.statusCode}');
      }
    } catch (e) {
      print('errorrr' + e.toString());
      throw Exception('Error fetching comics: $e');
    }
  }
}
