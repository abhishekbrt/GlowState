import 'package:glowstate/shared/domain/enums/check_in_type.dart';

import '../../domain/entities/check_in.dart';
import '../../domain/repositories/check_in_repository.dart';
import '../datasources/check_in_local_source.dart';

/// Implementation of [CheckInRepository]
///
/// Uses shared [CheckInType] from shared domain.
class CheckInRepositoryImpl implements CheckInRepository {
  final CheckInLocalSource localSource;

  CheckInRepositoryImpl({required this.localSource});

  @override
  Future<CheckIn> completeCheckIn({
    required CheckInType type,
    String? photoId,
  }) async {
    // TODO: Implement - create and save check-in
    throw UnimplementedError('CheckInRepositoryImpl.completeCheckIn');
  }

  @override
  Future<List<CheckIn>> getCheckInsForDate(DateTime date) async {
    // TODO: Implement - get check-ins for specific date
    throw UnimplementedError('CheckInRepositoryImpl.getCheckInsForDate');
  }

  @override
  Future<List<CheckIn>> getCheckInsForDateRange(
    DateTime start,
    DateTime end,
  ) async {
    // TODO: Implement - get check-ins in range
    throw UnimplementedError('CheckInRepositoryImpl.getCheckInsForDateRange');
  }

  @override
  Future<bool> hasCompletedCheckIn(DateTime date, CheckInType type) async {
    // TODO: Implement - check if specific check-in exists
    throw UnimplementedError('CheckInRepositoryImpl.hasCompletedCheckIn');
  }

  @override
  Future<CheckIn?> getTodayMorningCheckIn() async {
    // TODO: Implement - get today's morning check-in
    throw UnimplementedError('CheckInRepositoryImpl.getTodayMorningCheckIn');
  }

  @override
  Future<CheckIn?> getTodayNightCheckIn() async {
    // TODO: Implement - get today's night check-in
    throw UnimplementedError('CheckInRepositoryImpl.getTodayNightCheckIn');
  }

  @override
  Future<int> getTotalPoints() async {
    // TODO: Implement - sum all points earned
    throw UnimplementedError('CheckInRepositoryImpl.getTotalPoints');
  }

  @override
  Future<List<CheckIn>> getCurrentCycleCheckIns() async {
    // TODO: Implement - get last 30 days of check-ins
    throw UnimplementedError('CheckInRepositoryImpl.getCurrentCycleCheckIns');
  }
}
