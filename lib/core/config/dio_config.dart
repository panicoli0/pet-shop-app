import 'package:dio/dio.dart';

class DioConfig {
  static Dio createDio() {
    final dio = Dio();

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add common headers
          options.headers['Content-Type'] = 'application/json';
          return handler.next(options);
        },
        onError: (error, handler) {
          // Handle common errors
          return handler.next(error);
        },
      ),
    );

    return dio;
  }
}
