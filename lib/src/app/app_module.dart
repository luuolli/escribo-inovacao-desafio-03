import 'package:flutter_modular/flutter_modular.dart';

import '../features/home/home_page.dart';

class AppModule extends Module {
  // @override
  // List<Bind<Object>> get binds => super.binds;

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const HomePage()),
      ];
}
