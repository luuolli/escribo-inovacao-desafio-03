import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starwars/src/core/core.dart';
import 'package:starwars/src/features/films/repositories/repositories.dart';

void main() {
  Api api = Api(client: Dio());
  IFilmRepository repository = FilmRepositoryImpl(customApi: api);

  test('Fetch films', () async {
    var films = await repository.fetchMovies(page: 1);
    expect(films.count, 6);
  });
}
