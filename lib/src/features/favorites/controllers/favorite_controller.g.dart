// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FavoriteStore on _FavoriteStoreBase, Store {
  final _$_loadingStateAtom = Atom(name: '_FavoriteStoreBase._loadingState');

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

  final _$_favoritesAtom = Atom(name: '_FavoriteStoreBase._favorites');

  @override
  ObservableList<Favorite>? get _favorites {
    _$_favoritesAtom.reportRead();
    return super._favorites;
  }

  @override
  set _favorites(ObservableList<Favorite>? value) {
    _$_favoritesAtom.reportWrite(value, super._favorites, () {
      super._favorites = value;
    });
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
