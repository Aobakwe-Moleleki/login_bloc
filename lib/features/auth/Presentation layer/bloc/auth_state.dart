/*
  state of then application
*/

import 'package:equatable/equatable.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, failed }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.rememberedEmail,
  });

  final AuthStatus status;
  final String? errorMessage;
  final String? rememberedEmail;

  AuthState copyWith({
    AuthStatus? status,
    String? errorMessage,
    String? rememberedEmail,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      rememberedEmail: rememberedEmail,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, errorMessage, rememberedEmail];
}
