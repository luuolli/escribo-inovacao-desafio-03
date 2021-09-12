// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PeopleStore on _PeopleStoreBase, Store {
  final _$_loadingStateAtom = Atom(name: '_PeopleStoreBase._loadingState');

  @override
  ConnectionState get _loadingState {
    _$_loadingStateAtom.reportRead();
    return super._loadingState;
  }

  @override
  set _loadingState(ConnectionState value) {
    _$_loadingStateAtom.reportWrite(value, super._loadingState, () {
      super._loadingState = value;
    });
  }

  final _$_peoplePaginationAtom =
      Atom(name: '_PeopleStoreBase._peoplePagination');

  @override
  PeoplePagination? get _peoplePagination {
    _$_peoplePaginationAtom.reportRead();
    return super._peoplePagination;
  }

  @override
  set _peoplePagination(PeoplePagination? value) {
    _$_peoplePaginationAtom.reportWrite(value, super._peoplePagination, () {
      super._peoplePagination = value;
    });
  }

  final _$_peoplesAtom = Atom(name: '_PeopleStoreBase._peoples');

  @override
  ObservableList<People>? get _peoples {
    _$_peoplesAtom.reportRead();
    return super._peoples;
  }

  @override
  set _peoples(ObservableList<People>? value) {
    _$_peoplesAtom.reportWrite(value, super._peoples, () {
      super._peoples = value;
    });
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
