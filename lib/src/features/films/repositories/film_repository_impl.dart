import 'package:dio/dio.dart';
import 'package:starwars/src/core/core.dart';

import '../models/films_pagination_model.dart';
import 'film_repository_interface.dart';

class FilmRepositoryImpl implements IFilmRepository {
  late Api _api;

  @override
  Dio get api => _api.client;

  FilmRepositoryImpl({required Api customApi}) {
    _api = customApi;
  }

  @override
  Future<FilmsPagination> fetchMovies({int page = 1}) async {
    try {
      return await api
          .get('/films/?page=$page')
          .then((response) => FilmsPagination.fromMap(response.data));
    } on DioError catch (e) {
      throw e.message;
    }
  }
}
