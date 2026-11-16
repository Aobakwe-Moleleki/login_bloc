/*
API CONSTANTS
 */

class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://regres.in/api';
  static const String loginEndpoint = '/login';
  static const String registerEndpoint = '/register';

  static const Duration connectionTimedout = Duration(seconds: 15);
  static const Duration recaiveTimeout = Duration(seconds: 15);
}
