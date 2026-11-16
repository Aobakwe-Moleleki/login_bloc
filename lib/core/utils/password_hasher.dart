/*
 P A S S W O R D - H A S H E R
 */

import 'dart:convert';

import 'package:crypto/crypto.dart';

class PasswordHasher {
  PasswordHasher._();

  /// Hashes [password] with SHA-256. One-way — there is no "unhash".
  /// Login works by hashing the entered password and comparing hashes,
  /// never by decrypting the stored value.

  static String hash(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }
}
