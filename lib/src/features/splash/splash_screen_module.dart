import 'package:flutter_modular/flutter_modular.dart';

import 'views/splash_screen.dart';

class SplashScreenModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const SplashScreen()),
      ];
}
