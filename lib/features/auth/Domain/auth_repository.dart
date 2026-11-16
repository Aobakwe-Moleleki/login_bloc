/*
R E P O S I T O R Y
- DISCRIBE WHAT OUR APP CAN DO
 */

abstract class AuthRepository {
  Future<void> login({required String email, required String password});
  Future<void> register({required String email, required String password});
  Future<void> logout();
  Future<bool> hasValidSession();
  Future<void> rememberedEmail(String? email);
  Future<String?> getRememberedEmail();
}
