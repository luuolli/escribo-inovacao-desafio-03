import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwars/src/features/films/controllers/film_controller.dart';
import 'package:starwars/src/features/films/film_module.dart';

class FilmListView extends StatefulWidget {
  FilmListView({Key? key}) : super(key: key) {
    Modular.bindModule(FilmModule());
  }

  @override
  State<FilmListView> createState() => _FilmListViewState();
}

class _FilmListViewState extends State<FilmListView> {
  final FilmStore filmStore = Modular.get();

  @override
  void initState() {
    super.initState();
    filmStore.fetchFilms().whenComplete(() {
      filmStore.markFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (filmStore.loadingState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
        itemBuilder: (_, index) {
          if (filmStore.filmItemsList != null) {
            return filmStore.filmItemsList![index];
          }
          return Container();
        },
        itemCount: filmStore.filmItemsList?.length ?? 0,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 5);
        },
      );
    });
  }
}
