// lib/features/auth/data/datasources/auth_remote_data_source.dart
abstract class AuthRemoteDataSource {
  Future<String> login({required String email, required String password});
  Future<String> register({required String email, required String password});
}