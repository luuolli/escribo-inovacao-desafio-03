import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwars/src/features/favorites/controllers/favorite_controller.dart';
import 'package:starwars/src/features/favorites/services/favorite_database.dart';
import 'package:starwars/src/features/home/home_page.dart';
import 'package:starwars/src/features/starwars_webview/views/starwars_web_page.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => FavoriteDatabase(), isLazy: false),
        Bind((i) => FavoriteStore(favoriteDatabase: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => HomePage(favoriteStore: Modular.get()),
          children: [
            ChildRoute(
              'starwars-web',
              child: (_, __) => const StarwarsWebPage(),
            ),
          ],
        )
      ];
}
