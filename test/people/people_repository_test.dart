import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starwars/src/core/core.dart';
import 'package:starwars/src/features/people/repositories/people_repository_impl.dart';

void main() {
  var api = Api(client: Dio());
  var repository = PeopleRepositoryImpl(customDio: api);

  test('Fetch peoples', () async {
    var peoples = await repository.fetchPeoples();
    expect(peoples.count, 82);
  });

  test('Fetch peoples page preivous url', () async {
    var peoples = await repository.fetchPeoples(page: 3);
    expect(peoples.previewPageUrl != null, true);
  });
}
