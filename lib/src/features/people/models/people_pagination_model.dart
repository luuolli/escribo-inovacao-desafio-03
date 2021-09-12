import 'dart:convert';

import 'people_model.dart';

class PeoplePagination {
  late final int count;
  late final String? nextPageUrl;
  late final String? previewPageUrl;
  late final List<People>? peoples;

  PeoplePagination({
    required this.count,
    this.nextPageUrl,
    this.previewPageUrl,
    this.peoples,
  });

  factory PeoplePagination.fromMap(Map<String, dynamic> map) {
    return PeoplePagination(
      count: map['count'],
      nextPageUrl: map['next'],
      previewPageUrl: map['previous'],
      peoples: (map['results'] as List)
          .map((people) => People.fromMap(people))
          .toList(),
    );
  }

  factory PeoplePagination.fromJson(String source) =>
      PeoplePagination.fromMap(json.decode(source));

  @override
  String toString() =>
      'PeoplePagination(count: $count,nextPageUrl: $nextPageUrl, previewPageUrl: $previewPageUrl, movies: $peoples)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PeoplePagination &&
        other.count == count &&
        other.nextPageUrl == nextPageUrl &&
        other.previewPageUrl == previewPageUrl &&
        other.peoples == peoples;
  }

  @override
  int get hashCode =>
      count.hashCode ^
      nextPageUrl.hashCode ^
      previewPageUrl.hashCode ^
      peoples.hashCode;
}
