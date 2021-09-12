import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwars/src/core/core.dart';
import 'package:starwars/src/features/films/film_module.dart';

import '../features/home/home_page.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => Dio()),
        Bind.singleton((i) => Api(client: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const HomePage(), children: [
          ModuleRoute('/film', module: FilmModule()),
        ]),
      ];
}
