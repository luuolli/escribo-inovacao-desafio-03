import 'package:flutter_test/flutter_test.dart';
import 'package:starwars/src/core/core.dart';
import 'package:starwars/src/features/favorites/models/favorite_model.dart';

void main() {
  test('Favorite from map', () {
    var map = {'id': 1, 'name': 'Lucas', 'type': 'film'};

    var favorite = Favorite.fromMap(map);
    expect(favorite.type, FavoriteType.film);
  });

  test('Favorite to map', () {
    var favorite =
        Favorite(id: 1, name: 'Lucas', type: FavoriteType.film).toMap();

    expect(favorite['type'], 'film');
  });
}
