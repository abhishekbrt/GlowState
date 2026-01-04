import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:glowstate/features/auth/data/datasources/auth_local_source.dart';
import 'package:glowstate/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:glowstate/features/auth/domain/repositories/auth_repository.dart';

part 'auth_repository_provider.g.dart';

@Riverpod(keepAlive: true)
AuthLocalSource authLocalSource(AuthLocalSourceRef ref) {
  return AuthLocalSourceImpl();
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(localSource: ref.watch(authLocalSourceProvider));
}
