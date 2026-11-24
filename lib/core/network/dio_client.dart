// lib/core/network/dio_client.dart
import 'package:dio/dio.dart';

import 'api_constants.dart';

class DioClient {
  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Logs requests/responses to the console — useful while learning,
    // remove or gate behind a debug flag before any real release.
    _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  late final Dio _dio;

  Dio get instance => _dio;
}