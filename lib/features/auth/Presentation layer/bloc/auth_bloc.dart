/*
 B L O C

 => BLOC takes the event and emit a state based on the receive event. 
 */

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/features/auth/Domain/auth_failure.dart';
import 'package:login_bloc/features/auth/Domain/auth_repository.dart';
import 'package:login_bloc/features/auth/Presentation%20layer/bloc/auth_event.dart';
import 'package:login_bloc/features/auth/Presentation%20layer/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const AuthState()) {
    on<AppStarted>(_onAppStarted);
    on<LoginRequested>(onLoginRequested);
    on<RegisterRequested>(onRegisterRequested);
    on<LogoutRequested>(onLogoutRequested);
  }
  final AuthRepository _authRepository;

  FutureOr<void> onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.logout();
    emit(state.copyWith(status: AuthStatus.unauthenticated));
  }

  FutureOr<void> onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      await _authRepository.register(
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(status: AuthStatus.authenticated));
    } on AuthFailure catch (failure) {
      emit(
        state.copyWith(
          status: AuthStatus.failed,
          errorMessage: failure.message,
        ),
      );
    }
  }

  FutureOr<void> _onAppStarted(
    AppStarted event,
    Emitter<AuthState> emit,
  ) async {
    final isLoaggedIn = await _authRepository.hasValidSession();
    final rememberedEmail = await _authRepository.getRememberedEmail();

    emit(
      state.copyWith(
        status: isLoaggedIn
            ? AuthStatus.authenticated
            : AuthStatus.unauthenticated,
        rememberedEmail: rememberedEmail,
      ),
    );
  }

  FutureOr<void> onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.login(email: event.email, password: event.password);
    await _authRepository.rememberedEmail(
      event.rememberMe ? event.email : null,
    );
    try {
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          rememberedEmail: event.rememberMe ? event.email : null,
        ),
      );
    } on AuthFailure catch (failure) {
      emit(
        state.copyWith(
          status: AuthStatus.failed,
          errorMessage: failure.message,
        ),
      );
    }
  }
}
