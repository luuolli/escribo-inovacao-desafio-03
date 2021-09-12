import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwars/src/core/core.dart';
import 'package:starwars/src/features/favorites/controllers/favorite_controller.dart';
import 'package:starwars/src/features/favorites/services/favorite_database.dart';

import '../features/home/home_page.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => Dio()),
        Bind.singleton((i) => Api(client: i())),

        // Favorite database

        Bind((i) => FavoriteDatabase(), isLazy: false),
        Bind((i) => FavoriteStore(favoriteDatabase: i()), export: true),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => HomePage(favoriteStore: Modular.get()),
        ),
      ];
}
