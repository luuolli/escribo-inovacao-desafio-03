import 'package:dio/dio.dart';

import 'api_interceptor.dart';

class Api {
  Dio client;

  Api({
    required this.client,
  }) {
    client.options.baseUrl = 'https://swapi.dev/api';
    client.options.connectTimeout = 8000;
    client.interceptors.add(ApiInterceptor());
  }
}
