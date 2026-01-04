import 'package:glowstate/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login({required String email, required String password});
  Future<User> register({
    required String email,
    required String password,
    String? displayName,
  });
  Future<void> logout();
  Future<User?> getCurrentUser();
  Future<void> resetPassword({required String email});
  Stream<User?> get authStateChanges;
}
