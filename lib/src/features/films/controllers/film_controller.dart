import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/core.dart';
import '../../favorites/controllers/favorite_controller.dart';
import '../components/film_component.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';

part 'film_controller.g.dart';

class FilmStore = _FilmStoreBase with _$FilmStore;

abstract class _FilmStoreBase with Store {
  final IFilmRepository repo;
  @observable
  ConnectionState _loadingState = ConnectionState.none;

  @observable
  FilmsPagination? _filmsPagination;

  @observable
  ObservableList<Film>? _films;

  _FilmStoreBase({required this.repo});
}

extension FilmStoreActions on _FilmStoreBase {
  @action
  Future<void> fetchFilms() async {
    if (_filmsPagination != null) return;
    _loadingState = ConnectionState.waiting;
    await repo.fetchMovies().then((result) {
      _filmsPagination = result;
      _films = ObservableList.of(_filmsPagination!.films!);
      _loadingState = ConnectionState.done;
    });
    _loadingState = ConnectionState.none;
  }

  @action
  void markFavorites() {
    if (_films == null) return;
    var favoriteFilms = Modular.get<FavoriteStore>()
        .favorites
        ?.where((filme) => filme.type == FavoriteType.film);

    if (favoriteFilms == null || favoriteFilms.isEmpty) {
      _films?.forEach((element) {
        element.isFavorite = false;
      });
    } else {
      for (var film in favoriteFilms) {
        _films?.firstWhere((element) {
          return element.id == film.id;
        }).isFavorite = true;
      }
    }

    _films = ObservableList.of(_films!);
  }

  @action
  void markOrUnmarkfavorite(int id) {
    var film = _films?.firstWhere((film) => film.id == id);
    if (film == null) return;

    film.toggleFavorite();
    if (film.isFavorite) {
      Modular.get<FavoriteStore>().addFilmToFavorite(film: film);
    } else if (!film.isFavorite) {
      Modular.get<FavoriteStore>().removeFilmFromFavorite(film: film);
    }

    _films = ObservableList.of(_films!);
  }
}

extension FilmStoreComputeds on _FilmStoreBase {
  @computed
  ConnectionState get loadingState => _loadingState;

  @computed
  FilmsPagination? get filmsPagination => _filmsPagination;

  @computed
  List<FilmWidget>? get filmItemsList => _films!
      .map(
        (film) => FilmWidget(
          id: film.id,
          isFavorite: film.isFavorite,
          title: film.title,
          episodeId: film.episodeId,
          releaseDate: film.releaseDate,
          onFavorited: markOrUnmarkfavorite,
        ),
      )
      .toList();
}
