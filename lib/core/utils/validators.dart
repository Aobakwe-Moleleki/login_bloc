import 'package:flutter/material.dart';

class Validators {
  Validators._();

  static final RegExp _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? email(String? value) {
    final trimmer = value?.trimLeft() ?? '';
    if (trimmer.isEmpty) return 'Email is required';
    if (!_emailPattern.hasMatch(trimmer)) return 'Enter a valid email.';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required.';
    if (value.length < 6) return 'Password must be at least 6 characters long';
    return null;
  }

  static String? Function(String?) confirmPassword(
    TextEditingController passwordController,
  ) {
    return (value) {
      if (value == null || value.isEmpty) return 'Please confirm your password';
      if (value != passwordController.text) return 'Passwords do not match';
      return null;
    };
  }
}
