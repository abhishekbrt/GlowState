import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:glowstate/features/check_in/data/providers/check_in_repository_provider.dart';
import 'package:glowstate/features/check_in/domain/entities/check_in.dart';
// Note: CheckInType is used in the full implementation

part 'check_in_provider.g.dart';

@riverpod
class TodayCheckIns extends _$TodayCheckIns {
  @override
  FutureOr<TodayCheckInStatus> build() async {
    throw UnimplementedError('TodayCheckIns.build');
  }

  Future<void> completeMorningCheckIn({String? photoId}) async {
    throw UnimplementedError('TodayCheckIns.completeMorningCheckIn');
  }

  Future<void> completeNightCheckIn({String? photoId}) async {
    throw UnimplementedError('TodayCheckIns.completeNightCheckIn');
  }
}

class TodayCheckInStatus {
  final CheckIn? morningCheckIn;
  final CheckIn? nightCheckIn;

  const TodayCheckInStatus({this.morningCheckIn, this.nightCheckIn});

  bool get hasMorningCheckIn => morningCheckIn != null;
  bool get hasNightCheckIn => nightCheckIn != null;
  bool get isComplete => hasMorningCheckIn && hasNightCheckIn;
}

@riverpod
Future<int> totalPoints(TotalPointsRef ref) async {
  final repository = ref.watch(checkInRepositoryProvider);
  return repository.getTotalPoints();
}
