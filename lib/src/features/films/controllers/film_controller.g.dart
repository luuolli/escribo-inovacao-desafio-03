// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FilmStore on _FilmStoreBase, Store {
  final _$_loadingStateAtom = Atom(name: '_FilmStoreBase._loadingState');

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

  final _$_filmsPaginationAtom = Atom(name: '_FilmStoreBase._filmsPagination');

  @override
  FilmsPagination? get _filmsPagination {
    _$_filmsPaginationAtom.reportRead();
    return super._filmsPagination;
  }

  @override
  set _filmsPagination(FilmsPagination? value) {
    _$_filmsPaginationAtom.reportWrite(value, super._filmsPagination, () {
      super._filmsPagination = value;
    });
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
