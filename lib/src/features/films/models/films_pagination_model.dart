import 'dart:convert';

import 'film_model.dart';

class FilmsPagination {
  late final int count;
  late final String? nextPageUrl;
  late final String? previousPageUrl;
  late final List<Film>? films;

  FilmsPagination({
    required this.count,
    this.nextPageUrl,
    this.previousPageUrl,
    this.films,
  });

  factory FilmsPagination.fromMap(Map<String, dynamic> map) {
    return FilmsPagination(
      count: map['count'],
      nextPageUrl: map['next'],
      previousPageUrl: map['previous'],
      films:
          (map['results'] as List).map((movie) => Film.fromMap(movie)).toList(),
    );
  }

  factory FilmsPagination.fromJson(String source) =>
      FilmsPagination.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MoviesPagination(count: $count, nextPageUrl: $nextPageUrl, previousPageUrl: $previousPageUrl, films: $films)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FilmsPagination &&
        other.count == count &&
        other.nextPageUrl == nextPageUrl &&
        other.previousPageUrl == previousPageUrl &&
        other.films == films;
  }

  @override
  int get hashCode {
    return count.hashCode ^
        nextPageUrl.hashCode ^
        previousPageUrl.hashCode ^
        films.hashCode;
  }
}
