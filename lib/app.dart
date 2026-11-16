import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/features/auth/Presentation%20layer/bloc/auth_bloc.dart';
import 'package:login_bloc/features/auth/Presentation%20layer/bloc/auth_state.dart';
import 'package:login_bloc/features/auth/Presentation%20layer/pages/home_page.dart';
import 'package:login_bloc/features/auth/Presentation%20layer/pages/login_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          switch (state.status) {
            case AuthStatus.authenticated:
              return const HomePage();
            case AuthStatus.initial:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            default:
              return const LoginPage();
          }
        },
      ),
    );
  }
}
