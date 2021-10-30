import 'dart:convert';

class Film {
  late int id;
  bool isFavorite;
  late final String title;
  late final int episodeId;
  late final String openingCrawl;
  late final String director;
  late final String producer;
  late final String releaseDate;
  late final String url;

  int getIdFromUrl() {
    var regexp = RegExp(r'films/(\d+)/');
    return int.parse(regexp.allMatches(url).first.group(1)!);
  }

  bool toggleFavorite() {
    isFavorite = !isFavorite;
    return isFavorite;
  }

  Film({
    this.isFavorite = false,
    required this.title,
    required this.episodeId,
    required this.openingCrawl,
    required this.director,
    required this.producer,
    required this.releaseDate,
    required this.url,
  }) {
    id = getIdFromUrl();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'episode_id': episodeId,
      'opening_crawl': openingCrawl,
      'director': director,
      'producer': producer,
      'release_date': releaseDate,
    };
  }

  String toJson() => json.encode(toMap());

  factory Film.fromMap(Map<String, dynamic> map) {
    return Film(
      title: map['title'],
      episodeId: map['episode_id'],
      openingCrawl: map['opening_crawl'],
      director: map['director'],
      producer: map['producer'],
      releaseDate: map['release_date'],
      url: map['url'],
    );
  }

  factory Film.fromJson(String source) => Film.fromMap(json.decode(source));

  @override
  String toString() {
    return '''
      Movie(
        id: $id,
        title: $title, 
        episodeId: $episodeId, 
        openingCrawl: $openingCrawl, 
        director: $director, 
        producer: $producer, 
        releaseDate: $releaseDate, 
        url: $url
      )
      ''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Film &&
        other.title == title &&
        other.episodeId == episodeId &&
        other.openingCrawl == openingCrawl &&
        other.director == director &&
        other.producer == producer &&
        other.releaseDate == releaseDate &&
        other.url == url;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        episodeId.hashCode ^
        openingCrawl.hashCode ^
        director.hashCode ^
        producer.hashCode ^
        releaseDate.hashCode ^
        url.hashCode;
  }
}
