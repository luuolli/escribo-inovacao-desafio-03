import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:starwars/src/features/films/components/film_component.dart';
import 'package:starwars/src/features/films/services/film_database.dart';

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

  _FilmStoreBase({required this.repo});
}

extension FilmStoreActions on _FilmStoreBase {
  @action
  Future<void> fetchFilms() async {
    _loadingState = ConnectionState.waiting;
    await repo.fetchMovies().then((result) {
      _filmsPagination = result;
      _loadingState = ConnectionState.done;
    });
    _loadingState = ConnectionState.none;
  }

  @action
  void favoriteOrUnfavorite(int id) {
    var film = _filmsPagination?.movies?.where((film) => film.id == id).first;
    film?.isFavorite = !film.isFavorite;

    _filmsPagination = _filmsPagination;
  }
}

extension FilmStoreComputeds on _FilmStoreBase {
  @computed
  ConnectionState get loadingState => _loadingState;

  @computed
  FilmsPagination? get filmsPagination => _filmsPagination;

  @computed
  List<FilmWidget>? get filmItemsList =>
      _filmsPagination?.movies!
          .map(
            (film) => FilmWidget(
              isFavorite: false,
              title: film.title,
              episodeId: film.episodeId,
              releaseDate: film.releaseDate,
            ),
          )
          .toList() ??
      [];
}
