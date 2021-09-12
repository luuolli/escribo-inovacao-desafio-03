import 'package:dio/dio.dart';

import '../models/models.dart';

abstract class IFilmRepository {
  Dio get api;

  Future<FilmsPagination> fetchMovies({int page = 1});
}
