/* 
 H O M E - P A G E
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc/features/auth/Presentation%20layer/bloc/auth_bloc.dart';
import 'package:login_bloc/features/auth/Presentation%20layer/bloc/auth_event.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        actions: [
          IconButton(
            onPressed: () =>
                context.read<AuthBloc>().add(const LogoutRequested()),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(child: Text('Logged In')),
    );
  }
}
