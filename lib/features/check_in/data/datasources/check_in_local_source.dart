import 'package:glowstate/features/check_in/domain/entities/check_in.dart';
import 'package:glowstate/features/check_in/domain/entities/check_in_type.dart';

abstract class CheckInLocalSource {
  Future<void> saveCheckIn(CheckIn checkIn);
  Future<List<CheckIn>> getCheckInsForDate(DateTime date);
  Future<List<CheckIn>> getCheckInsForDateRange(DateTime start, DateTime end);
  Future<CheckIn?> getCheckIn(DateTime date, CheckInType type);
  Future<int> getTotalPoints();
}

class CheckInLocalSourceImpl implements CheckInLocalSource {
  @override
  Future<void> saveCheckIn(CheckIn checkIn) async {
    throw UnimplementedError('CheckInLocalSourceImpl.saveCheckIn');
  }

  @override
  Future<List<CheckIn>> getCheckInsForDate(DateTime date) async {
    throw UnimplementedError('CheckInLocalSourceImpl.getCheckInsForDate');
  }

  @override
  Future<List<CheckIn>> getCheckInsForDateRange(
    DateTime start,
    DateTime end,
  ) async {
    throw UnimplementedError('CheckInLocalSourceImpl.getCheckInsForDateRange');
  }

  @override
  Future<CheckIn?> getCheckIn(DateTime date, CheckInType type) async {
    throw UnimplementedError('CheckInLocalSourceImpl.getCheckIn');
  }

  @override
  Future<int> getTotalPoints() async {
    throw UnimplementedError('CheckInLocalSourceImpl.getTotalPoints');
  }
}
