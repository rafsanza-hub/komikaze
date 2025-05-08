import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:komikaze/app/data/models/comic.dart';

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
}
