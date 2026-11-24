// lib/features/auth/data/datasources/auth_remote_data_source_impl.dart
//dio deals with connectingto the database
import 'package:dio/dio.dart';

import '../../../../core/network/api_constants.dart';
import '../../domain/auth_failure.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<String> login({required String email, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<String> register({required String email, required String password}) {
    // TODO: implement register
    throw UnimplementedError();
  }
  
 
  
}
