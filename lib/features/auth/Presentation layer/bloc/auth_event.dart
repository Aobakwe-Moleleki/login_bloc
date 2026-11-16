/*
  the app events.
  this is basically a list of think the user  can ask the app to do.
 */

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {
  const AppStarted();
}

class LoginRequested extends AuthEvent {
  const LoginRequested({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });

  final String email;
  final String password;
  final bool rememberMe;

  @override
  List<Object?> get props => [email, password, rememberMe];
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class RegisterRequested extends AuthEvent {
  const RegisterRequested({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

// class RememberMerequested extends AuthEvent {
//   const RememberMerequested({required this.email});

//   final String email;

//   @override
//   List<Object?> get props => [email];
// }
