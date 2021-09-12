import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
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
}

extension PeopleStoreComputeds on _PeopleStoreBase {
  @computed
  ConnectionState get loadingState => _loadingState;

  @computed
  List<PeopleWidget>? get peopleItemList => _peoples
      ?.map((people) => PeopleWidget(
            isFavorite: false,
            name: people.name,
            year: people.birthYear,
          ))
      .toList();
}
