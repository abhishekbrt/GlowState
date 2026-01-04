import 'package:flutter_test/flutter_test.dart';
import 'package:glowstate/features/streak/data/datasources/streak_local_source.dart';
import 'package:glowstate/features/streak/data/repositories/streak_repository_impl.dart';
import 'package:glowstate/features/streak/domain/entities/streak.dart';
import 'package:mocktail/mocktail.dart';

class MockStreakLocalSource extends Mock implements StreakLocalSource {}

class FakeStreak extends Fake implements Streak {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeStreak());
  });

  group('StreakRepositoryImpl', () {
    late StreakRepositoryImpl repository;
    late MockStreakLocalSource mockLocalSource;

    setUp(() {
      mockLocalSource = MockStreakLocalSource();
      repository = StreakRepositoryImpl(localSource: mockLocalSource);
    });

    group('getStreak', () {
      test('should return streak from local source', () async {
        final streak = Streak(
          currentStreak: 5,
          longestStreak: 10,
          lastCheckInDate: DateTime.now(),
          totalCheckIns: 20,
        );
        when(() => mockLocalSource.getStreak()).thenAnswer((_) async => streak);

        final result = await repository.getStreak();

        expect(result, equals(streak));
        verify(() => mockLocalSource.getStreak()).called(1);
      });

      test(
        'should return Streak.empty() if local source returns null',
        () async {
          when(() => mockLocalSource.getStreak()).thenAnswer((_) async => null);

          final result = await repository.getStreak();

          expect(result.currentStreak, 0);
          expect(result.lastCheckInDate, isNull);
        },
      );
    });

    group('recordCheckIn', () {
      test('should increment streak if checked in yesterday', () async {
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        final current = Streak(
          currentStreak: 5,
          longestStreak: 10,
          lastCheckInDate: yesterday,
          totalCheckIns: 20,
        );
        when(
          () => mockLocalSource.getStreak(),
        ).thenAnswer((_) async => current);
        when(() => mockLocalSource.saveStreak(any())).thenAnswer((_) async {});

        final result = await repository.recordCheckIn();

        expect(result.currentStreak, 6);
        expect(result.totalCheckIns, 21);
        verify(() => mockLocalSource.saveStreak(any())).called(1);
      });

      test('should reset streak to 1 if missed a day', () async {
        final dayBeforeYesterday = DateTime.now().subtract(
          const Duration(days: 2),
        );
        final current = Streak(
          currentStreak: 5,
          longestStreak: 10,
          lastCheckInDate: dayBeforeYesterday,
          totalCheckIns: 20,
        );
        when(
          () => mockLocalSource.getStreak(),
        ).thenAnswer((_) async => current);
        when(() => mockLocalSource.saveStreak(any())).thenAnswer((_) async {});

        final result = await repository.recordCheckIn();

        expect(result.currentStreak, 1);
        verify(() => mockLocalSource.saveStreak(any())).called(1);
      });

      test('should not change streak if already checked in today', () async {
        final today = DateTime.now();
        final current = Streak(
          currentStreak: 5,
          longestStreak: 10,
          lastCheckInDate: today,
          totalCheckIns: 20,
        );
        when(
          () => mockLocalSource.getStreak(),
        ).thenAnswer((_) async => current);

        final result = await repository.recordCheckIn();

        expect(result.currentStreak, 5);
        verifyNever(() => mockLocalSource.saveStreak(any()));
      });
    });

    group('validateStreak', () {
      test('should reset currentStreak to 0 if day missed', () async {
        final dayBeforeYesterday = DateTime.now().subtract(
          const Duration(days: 2),
        );
        final current = Streak(
          currentStreak: 5,
          longestStreak: 10,
          lastCheckInDate: dayBeforeYesterday,
          totalCheckIns: 20,
        );
        when(
          () => mockLocalSource.getStreak(),
        ).thenAnswer((_) async => current);
        when(() => mockLocalSource.saveStreak(any())).thenAnswer((_) async {});

        final result = await repository.validateStreak();

        expect(result.currentStreak, 0);
        expect(result.longestStreak, 10);
        verify(() => mockLocalSource.saveStreak(any())).called(1);
      });

      test(
        'should keep streak if still active (checked in yesterday)',
        () async {
          final yesterday = DateTime.now().subtract(const Duration(days: 1));
          final current = Streak(
            currentStreak: 5,
            longestStreak: 10,
            lastCheckInDate: yesterday,
            totalCheckIns: 20,
          );
          when(
            () => mockLocalSource.getStreak(),
          ).thenAnswer((_) async => current);

          final result = await repository.validateStreak();

          expect(result.currentStreak, 5);
          verifyNever(() => mockLocalSource.saveStreak(any()));
        },
      );
    });
  });
}
