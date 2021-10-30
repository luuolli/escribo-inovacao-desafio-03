import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../core/core.dart';
import '../../films/models/film_model.dart';
import '../../people/models/models.dart';
import '../components/favorite_component.dart';
import '../models/models.dart';
import '../services/favorite_database.dart';

part 'favorite_controller.g.dart';

class FavoriteStore = _FavoriteStoreBase with _$FavoriteStore;

abstract class _FavoriteStoreBase with Store {
  final FavoriteDatabase favoriteDatabase;

  @observable
  ConnectionState _loadingState = ConnectionState.none;

  @observable
  ObservableList<Favorite>? _favorites;

  _FavoriteStoreBase({required this.favoriteDatabase});
}

extension FavoriteStoreActions on _FavoriteStoreBase {
  @action
  Future<void> load() async {
    _loadingState = ConnectionState.waiting;
    try {
      await favoriteDatabase.open();
      favoriteDatabase.selectAll().then(
        (result) {
          if (result != null) _favorites = ObservableList.of(result);
        },
      );
      _loadingState = ConnectionState.done;
    } catch (e) {
      throw "Não foi possível abrir banco de dados no momento";
    }
    _loadingState = ConnectionState.none;
  }

  @action
  void closeDatabase() {
    favoriteDatabase.close();
  }

  @action
  void unfavorite(int id, FavoriteType type) {
    favoriteDatabase.delete(id, type);
    _favorites?.removeWhere(
      (element) => element.id == id && element.type == type,
    );
  }

  // Add film to favorites
  @action
  void addFilmToFavorite({required Film film}) {
    var favorite = Favorite(
      id: film.id,
      name: film.title,
      type: FavoriteType.film,
    );
    favoriteDatabase.insert(favorite);
    _favorites?.add(favorite);
  }

  // Remove film from favorites
  @action
  void removeFilmFromFavorite({required Film film}) {
    favoriteDatabase.delete(film.id, FavoriteType.film);
    _favorites?.removeWhere((value) => value.id == film.id);
  }

  // Add peoples to favorites
  @action
  void addPeopleToFavorite({required People people}) {
    var favorite = Favorite(
      id: people.id,
      name: people.name,
      type: FavoriteType.people,
    );
    favoriteDatabase.insert(favorite);
  }

  // Remove people from favorites
  @action
  void removePeopleFromFavorite({required People people}) {
    favoriteDatabase.delete(people.id, FavoriteType.people);
  }
}

extension FavoriteStoreComputeds on _FavoriteStoreBase {
  @computed
  ConnectionState get loadingState => _loadingState;

  @computed
  List<Favorite>? get favorites => _favorites;

  @computed
  List<FavoriteWidget>? get favoriteItemList => _favorites?.map((favorite) {
        return FavoriteWidget(
          id: favorite.id,
          isFavorite: true,
          type: favorite.type,
          name: favorite.name,
          onUnfavorite: unfavorite,
        );
      }).toList();
}
