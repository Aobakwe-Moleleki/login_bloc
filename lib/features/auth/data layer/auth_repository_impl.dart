/*
This is where we implement the repository. This is where the majority of the logic will be found
The function here will accept a database in the form of a Box. or better yet Box is the database.
 */

import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_bloc/core/storage/auth_box.dart';
import 'package:login_bloc/core/utils/password_hasher.dart';
import 'package:login_bloc/features/auth/Domain/auth_failure.dart';
import 'package:login_bloc/features/auth/Domain/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({required Box authBox, required Box usersBox})
    : _authBox = authBox,
      _usersBox = usersBox;

  final Box _usersBox;
  final Box _authBox;
  @override
  Future<bool> hasValidSession() async {
    return _authBox.get(AuthBox.loggedInKey, defaultValue: false);
  }

  @override
  Future<void> login({required email, required password}) async {
    final normalizedEmail = email.toLowerCase().trim();
    final storedHash = _usersBox.get(normalizedEmail) as String;
    final enterHash = PasswordHasher.hash(password);

    if (enterHash != storedHash || enterHash == null) {
      throw const AuthFailure('email/password invalid');
    }
    await _authBox.put(AuthBox.loggedInKey, true);
    await _authBox.put(normalizedEmail, enterHash);
  }

  @override
  Future<void> logout() async {
    await _authBox.delete(AuthBox.loggedInKey);
    await _authBox.delete(AuthBox.emailKey);
  }

  @override
  Future<void> register({
    required String email,
    required String password,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();

    if (normalizedEmail.isEmpty || password.isEmpty) {
      throw AuthFailure('Enter email/password');
    }
    if (password.length < 6) {
      throw AuthFailure('Password must be at least 6 characters long');
    }
    if (_authBox.containsKey(normalizedEmail)) {
      throw AuthFailure('Account already exist');
    }

    final hashedPassword = PasswordHasher.hash(password);
    await _authBox.put(AuthBox.loggedInKey, true);
    await _authBox.put(AuthBox.emailKey, normalizedEmail);
    await _usersBox.put(normalizedEmail, hashedPassword);
  }

  @override
  Future<String?> getRememberedEmail() async {
    return _authBox.get(AuthBox.rememberedEmailKey) as String?;
  }

  @override
  // In AuthRepository:
  Future<void> rememberedEmail(String? email) async {
    if (email == null) {
      await _authBox.delete('remembered_email');
    } else {
      await _authBox.put('remembered_email', email);
    }
  }
}
