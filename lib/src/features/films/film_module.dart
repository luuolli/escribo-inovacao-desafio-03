import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwars/src/features/films/controllers/film_controller.dart';
import 'package:starwars/src/features/films/repositories/repositories.dart';
import 'package:starwars/src/features/films/services/film_database.dart';

class FilmModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => FilmDatabase()),
        Bind<IFilmRepository>((i) => FilmRepositoryImpl(customApi: i())),
        Bind.singleton((i) => FilmStore(repo: i()))
      ];
}
