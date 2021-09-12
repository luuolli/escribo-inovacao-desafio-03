import 'package:flutter_modular/flutter_modular.dart';
import 'package:starwars/src/features/people/controllers/people_controller.dart';
import 'package:starwars/src/features/people/repositories/people_repository_impl.dart';
import 'package:starwars/src/features/people/repositories/people_repository_interface.dart';

class PeopleModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind<IPeopleRepository>((i) => PeopleRepositoryImpl(customDio: i())),
        Bind.lazySingleton((i) => PeopleStore(repo: i())),
      ];
}
