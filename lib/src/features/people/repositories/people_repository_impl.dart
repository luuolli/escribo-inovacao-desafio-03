import 'package:dio/dio.dart';

import '../../../core/core.dart';
import '../models/models.dart';
import 'people_repository_interface.dart';

class PeopleRepositoryImpl implements IPeopleRepository {
  late Api _api;

  @override
  Dio get api => _api.client;

  PeopleRepositoryImpl({required Api customDio}) {
    _api = customDio;
  }

  @override
  Future<PeoplePagination> fetchPeoples({int page = 1}) async {
    try {
      return await api.get('/people/?page=$page').then((response) {
        return PeoplePagination.fromMap(response.data);
      });
    } on DioError catch (e) {
      throw e.message;
    }
  }
}
