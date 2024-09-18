import 'dart:ffi';

class MovieDetails {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final int runtime;
  final String releaseDate;
  final double voteAverage;

  MovieDetails({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.runtime,
    required this.releaseDate,
    required this.voteAverage,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      runtime: json['runtime'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'],
    );
  }
}