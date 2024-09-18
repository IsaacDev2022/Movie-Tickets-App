import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';
import '../models/movie_details.dart';

class ApiService {
  final String _apiKey = 'b9f82c4c61f5f44c6b230fb8a85fd600';
  final String _baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Movie> movies = (data['results'] as List).map((movieJson) => Movie.fromJson(movieJson)).toList();
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }

  }

  Future<MovieDetails> fetchMovieDetail(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/movie/$id?api_key=$_apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return MovieDetails.fromJson(data);
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
