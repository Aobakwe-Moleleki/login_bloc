/*
API CONSTANTS
 */

// lib/core/network/api_constants.dart
class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://reqres.in/api';
  static const String loginEndpoint = '/login';
  static const String registerEndpoint = '/register';

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
} 