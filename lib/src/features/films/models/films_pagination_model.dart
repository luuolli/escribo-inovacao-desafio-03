import 'dart:convert';

import 'film_model.dart';

class FilmsPagination {
  late final int count;
  late final String? nextPageUrl;
  late final String? previewPageUrl;
  late final List<Film>? movies;

  FilmsPagination({
    required this.count,
    this.nextPageUrl,
    this.previewPageUrl,
    this.movies,
  });

  factory FilmsPagination.fromMap(Map<String, dynamic> map) {
    return FilmsPagination(
      count: map['count'],
      nextPageUrl: map['next'],
      previewPageUrl: map['preview'],
      movies:
          (map['results'] as List).map((movie) => Film.fromMap(movie)).toList(),
    );
  }

  factory FilmsPagination.fromJson(String source) =>
      FilmsPagination.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MoviesPagination(count: $count, nextPageUrl: $nextPageUrl, previewPageUrl: $previewPageUrl, movies: $movies)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FilmsPagination &&
        other.count == count &&
        other.nextPageUrl == nextPageUrl &&
        other.previewPageUrl == previewPageUrl &&
        other.movies == movies;
  }

  @override
  int get hashCode {
    return count.hashCode ^
        nextPageUrl.hashCode ^
        previewPageUrl.hashCode ^
        movies.hashCode;
  }
}
