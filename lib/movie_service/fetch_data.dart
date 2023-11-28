import 'dart:convert';

import 'package:http/http.dart' as http;
class MovieService {
  static Future<List<Map<String, dynamic>>> fetchMovies() async {
    final apiKey = 'a07e22bc18f5cb106bfe4cc1f83ad8ed';
    final url = 'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['results']);
    } else {
      throw Exception('Failed to load movies');
    }
  }
}