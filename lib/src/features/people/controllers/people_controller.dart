import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:starwars/src/core/core.dart';
import 'package:starwars/src/features/favorites/controllers/favorite_controller.dart';
import 'package:starwars/src/features/people/components/people_component.dart';
import 'package:starwars/src/features/people/models/models.dart';
import 'package:starwars/src/features/people/repositories/people_repository_interface.dart';
part 'people_controller.g.dart';

class PeopleStore = _PeopleStoreBase with _$PeopleStore;

abstract class _PeopleStoreBase with Store {
  final IPeopleRepository repo;

  @observable
  ConnectionState _loadingState = ConnectionState.none;

  @observable
  PeoplePagination? _peoplePagination;

  @observable
  ObservableList<People>? _peoples;

  _PeopleStoreBase({required this.repo});
}

extension PeopleStoreActions on _PeopleStoreBase {
  @action
  Future<void> fetchPeople() async {
    if (_peoplePagination != null) return;
    _loadingState = ConnectionState.waiting;
    await repo.fetchPeoples().then(
      (result) {
        _peoplePagination = result;
        _peoples = ObservableList<People>.of(_peoplePagination!.peoples!);
        _loadingState = ConnectionState.done;
      },
    );
    _loadingState = ConnectionState.none;
  }

  @action
  void markFavorites() {
    if (_peoples == null) return;

    var favoritePeoples = Modular.get<FavoriteStore>()
        .favorites
        ?.where((people) => people.type == FavoriteType.people);

    if (favoritePeoples == null || favoritePeoples.isEmpty) {
      _peoples?.forEach((people) {
        people.isFavorite = false;
      });
    } else {
      for (var people in favoritePeoples) {
        _peoples?.firstWhere((element) {
          return element.id == people.id;
        }).isFavorite = true;
      }
    }

    _peoples = ObservableList.of(_peoples!);
  }

  @action
  void markOrUnmarkfavorite(int id) {
    var people = _peoples?.firstWhere((people) => people.id == id);

    if (people == null) return;

    people.isFavorite = !people.isFavorite;

    if (people.isFavorite) {
      Modular.get<FavoriteStore>().addPeopleToFavorite(people: people);
    } else {
      Modular.get<FavoriteStore>().removePeopleFromFavorite(people: people);
    }

    _peoples = ObservableList.of(_peoples!);
  }
}

extension PeopleStoreComputeds on _PeopleStoreBase {
  @computed
  ConnectionState get loadingState => _loadingState;

  @computed
  List<PeopleWidget>? get peopleItemList => _peoples
      ?.map((people) => PeopleWidget(
            id: people.id,
            isFavorite: people.isFavorite,
            name: people.name,
            year: people.birthYear,
            onFavorited: markOrUnmarkfavorite,
          ))
      .toList();
}
