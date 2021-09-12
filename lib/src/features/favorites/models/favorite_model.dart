import 'dart:convert';

import '../../../core/core.dart';

class Favorite {
  late final int id;
  late final String name;
  late final FavoriteType type;

  Favorite({
    required this.id,
    required this.name,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type.toString().replaceAll('FavoriteType.', ''),
    };
  }

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      id: map['id'],
      name: map['name'],
      type: FavoriteType.values
          .where((type) => type.toString() == "FavoriteType.${map['type']}")
          .first,
    );
  }

  String toJson() => json.encode(toMap());

  factory Favorite.fromJson(String source) =>
      Favorite.fromMap(json.decode(source));

  @override
  String toString() => 'Favorite(id: $id, name: $name, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Favorite && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
