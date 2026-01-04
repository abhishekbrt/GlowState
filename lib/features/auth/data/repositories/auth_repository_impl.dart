import 'dart:async';

import 'package:glowstate/core/error/exceptions.dart';
import 'package:glowstate/features/auth/data/datasources/auth_local_source.dart';
import 'package:glowstate/features/auth/data/models/user_model.dart';
import 'package:glowstate/features/auth/domain/entities/user.dart';
import 'package:glowstate/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalSource _localSource;
  final _authStateController = StreamController<User?>.broadcast();

  AuthRepositoryImpl({required AuthLocalSource localSource})
    : _localSource = localSource;

  @override
  Future<User> login({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email.isEmpty || password.isEmpty) {
      throw const AuthException(message: 'Email and password are required');
    }

    if (password.length < 8) {
      throw const AuthException(message: 'Invalid credentials');
    }

    final user = UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      displayName: email.split('@').first,
      createdAt: DateTime.now(),
    );

    await _localSource.cacheUser(user);
    _authStateController.add(user.toEntity());

    return user.toEntity();
  }

  @override
  Future<User> register({
    required String email,
    required String password,
    String? displayName,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email.isEmpty || password.isEmpty) {
      throw const AuthException(message: 'Email and password are required');
    }

    final user = UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      displayName: displayName ?? email.split('@').first,
      createdAt: DateTime.now(),
    );

    await _localSource.cacheUser(user);
    _authStateController.add(user.toEntity());

    return user.toEntity();
  }

  @override
  Future<void> logout() async {
    await _localSource.clearCache();
    _authStateController.add(null);
  }

  @override
  Future<User?> getCurrentUser() async {
    final cachedUser = await _localSource.getCachedUser();
    return cachedUser?.toEntity();
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Stream<User?> get authStateChanges => _authStateController.stream;
}
