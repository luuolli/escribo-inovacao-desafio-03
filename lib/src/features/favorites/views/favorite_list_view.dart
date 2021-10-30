import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwars/src/features/favorites/controllers/favorite_controller.dart';
import 'package:starwars/src/features/films/film_module.dart';

class FavoriteListView extends StatefulWidget {
  FavoriteListView({Key? key}) : super(key: key) {
    Modular.bindModule(FilmModule());
  }

  @override
  State<FavoriteListView> createState() => _FavoriteListViewState();
}

class _FavoriteListViewState extends State<FavoriteListView> {
  final FavoriteStore favoriteStore = Modular.get();

  @override
  void initState() {
    super.initState();
    favoriteStore.load();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (favoriteStore.loadingState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
        itemBuilder: (_, index) {
          if (favoriteStore.favoriteItemList != null) {
            return favoriteStore.favoriteItemList![index];
          }
          return Container();
        },
        itemCount: favoriteStore.favoriteItemList?.length ?? 0,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 5);
        },
      );
    });
  }
}
