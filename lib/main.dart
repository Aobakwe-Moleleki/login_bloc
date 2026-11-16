import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:login_bloc/app.dart';
import 'package:login_bloc/core/storage/auth_box.dart';
import 'package:login_bloc/core/storage/users_box.dart';
import 'package:login_bloc/features/auth/Domain/auth_repository.dart';
import 'package:login_bloc/features/auth/Presentation%20layer/bloc/auth_bloc.dart';
import 'package:login_bloc/features/auth/Presentation%20layer/bloc/auth_event.dart';
import 'package:login_bloc/features/auth/data%20layer/auth_repository_impl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final authBox = await Hive.openBox(AuthBox.name);
  final usersBox = await Hive.openBox(UsersBox.name);

  final AuthRepository authRepository = AuthRepositoryImpl(
    authBox: authBox,
    usersBox: usersBox,
  );

  runApp(
    BlocProvider(
      create: (_) =>
          AuthBloc(authRepository: authRepository)..add(const AppStarted()),
      child: const App(),
    ),
  );
}
