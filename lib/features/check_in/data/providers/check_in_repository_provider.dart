import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:glowstate/features/check_in/data/datasources/check_in_local_source.dart';
import 'package:glowstate/features/check_in/data/repositories/check_in_repository_impl.dart';
import 'package:glowstate/features/check_in/domain/repositories/check_in_repository.dart';

part 'check_in_repository_provider.g.dart';

@Riverpod(keepAlive: true)
CheckInLocalSource checkInLocalSource(CheckInLocalSourceRef ref) {
  return CheckInLocalSourceImpl();
}

@Riverpod(keepAlive: true)
CheckInRepository checkInRepository(CheckInRepositoryRef ref) {
  return CheckInRepositoryImpl(
    localSource: ref.watch(checkInLocalSourceProvider),
  );
}
