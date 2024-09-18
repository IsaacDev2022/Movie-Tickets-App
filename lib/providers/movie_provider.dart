import '../models/movie.dart';
import 'package:flutter/material.dart';

import '../models/movie_details.dart';
import '../services/api_service.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> _movies = [];
  MovieDetails? _selectedMovie;
  bool _isLoading = false;

  List<Movie> get movies => _movies;
  MovieDetails? get selectedMovie => _selectedMovie;
  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService();

  Future<void> fetchMovies() async {
    _isLoading = true;
    notifyListeners();
    _movies = await _apiService.fetchMovies();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMovieDetail(int id) async {
    _isLoading = true;
    notifyListeners();
    _selectedMovie = await _apiService.fetchMovieDetail(id);
    _isLoading = false;
    notifyListeners();
  }
}