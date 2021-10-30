import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/core.dart';
import '../features/home/home_module.dart';
import '../features/splash/splash_screen_module.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => Dio()),
        Bind.singleton((i) => Api(client: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/splash', module: SplashScreenModule()),
        ModuleRoute('/home', module: HomeModule())
      ];
}
