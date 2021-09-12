import 'package:dio/dio.dart';
import 'package:starwars/src/features/people/models/models.dart';

abstract class IPeopleRepository {
  Dio get api;

  Future<PeoplePagination> fetchPeoples({int page = 1});
}
