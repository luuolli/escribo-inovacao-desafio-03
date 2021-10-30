import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/core.dart';
import '../../favorites/controllers/favorite_controller.dart';
import '../components/people_component.dart';
import '../models/models.dart';
import '../repositories/repositories.dart';

part 'people_controller.g.dart';

class PeopleStore = _PeopleStoreBase with _$PeopleStore;

abstract class _PeopleStoreBase with Store {
  final IPeopleRepository repo;

  @observable
  ConnectionState _loadingState = ConnectionState.none;

  @observable
  ConnectionState _loadingMoreState = ConnectionState.none;

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
  Future<void> fetchNextPage() async {
    if (_peoplePagination == null || _peoplePagination!.nextPageUrl == null) {
      return;
    }

    _loadingMoreState = ConnectionState.waiting;
    var regexp = RegExp(r'page=(\d+)');
    var page = int.parse(
        regexp.allMatches(_peoplePagination!.nextPageUrl!).first.group(1)!);

    await repo.fetchPeoples(page: page + 1).then((result) {
      if (result.previewPageUrl != _peoplePagination?.previewPageUrl) {
        _peoplePagination = result;
        _peoples?.addAll(_peoplePagination!.peoples!);
      }
      _loadingMoreState = ConnectionState.done;
    });
    _loadingMoreState = ConnectionState.none;
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
  ConnectionState get loadingMoreState => _loadingMoreState;

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
