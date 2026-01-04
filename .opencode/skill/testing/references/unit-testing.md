# Unit Testing

Unit tests verify individual pieces of logic in isolation.

## Setup

```yaml
# pubspec.yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mocktail: ^1.0.0
```

---

## Testing ViewModels / ChangeNotifiers

```dart
// test/presentation/viewmodels/todo_viewmodel_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late TodoViewModel viewModel;
  late MockTodoRepository mockRepository;

  setUp(() {
    mockRepository = MockTodoRepository();
    viewModel = TodoViewModel(repository: mockRepository);
  });

  group('loadTodos', () {
    test('sets isLoading to true while loading', () async {
      // Arrange
      when(() => mockRepository.getTodos())
          .thenAnswer((_) async => [Todo(id: '1', title: 'Test')]);

      // Act
      final future = viewModel.loadTodos();

      // Assert - check loading state immediately
      expect(viewModel.isLoading, isTrue);
      
      await future;
      
      // After completion
      expect(viewModel.isLoading, isFalse);
    });

    test('populates todos on success', () async {
      // Arrange
      final testTodos = [
        Todo(id: '1', title: 'First'),
        Todo(id: '2', title: 'Second'),
      ];
      when(() => mockRepository.getTodos())
          .thenAnswer((_) async => testTodos);

      // Act
      await viewModel.loadTodos();

      // Assert
      expect(viewModel.todos, equals(testTodos));
      expect(viewModel.todos.length, equals(2));
      expect(viewModel.errorMessage, isNull);
    });

    test('sets errorMessage on failure', () async {
      // Arrange
      when(() => mockRepository.getTodos())
          .thenThrow(Exception('Network error'));

      // Act
      await viewModel.loadTodos();

      // Assert
      expect(viewModel.todos, isEmpty);
      expect(viewModel.errorMessage, isNotNull);
      expect(viewModel.errorMessage, contains('Network error'));
    });
  });

  group('addTodo', () {
    test('adds todo to list and calls repository', () async {
      // Arrange
      when(() => mockRepository.add(any())).thenAnswer((_) async {});
      
      // Act
      await viewModel.addTodo('New Task');

      // Assert
      expect(viewModel.todos.any((t) => t.title == 'New Task'), isTrue);
      verify(() => mockRepository.add(any())).called(1);
    });

    test('does not add empty todo', () async {
      // Act
      await viewModel.addTodo('');

      // Assert
      expect(viewModel.todos, isEmpty);
      verifyNever(() => mockRepository.add(any()));
    });
  });

  group('toggleTodo', () {
    test('toggles todo completion status', () async {
      // Arrange
      final todo = Todo(id: '1', title: 'Test', completed: false);
      when(() => mockRepository.getTodos())
          .thenAnswer((_) async => [todo]);
      when(() => mockRepository.update(any())).thenAnswer((_) async {});
      await viewModel.loadTodos();

      // Act
      await viewModel.toggleTodo('1');

      // Assert
      expect(viewModel.todos.first.completed, isTrue);
      verify(() => mockRepository.update(any())).called(1);
    });
  });
}
```

---

## Testing Repositories

```dart
// test/data/repositories/user_repository_impl_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}
class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}

void main() {
  late UserRepositoryImpl repository;
  late MockUserRemoteDataSource mockRemote;
  late MockUserLocalDataSource mockLocal;

  setUp(() {
    mockRemote = MockUserRemoteDataSource();
    mockLocal = MockUserLocalDataSource();
    repository = UserRepositoryImpl(
      remoteDataSource: mockRemote,
      localDataSource: mockLocal,
    );
  });

  group('getUser', () {
    const testId = '123';
    final testUserModel = UserModel(id: testId, name: 'Test User');

    test('returns user from remote and caches locally', () async {
      // Arrange
      when(() => mockRemote.getUser(testId))
          .thenAnswer((_) async => testUserModel);
      when(() => mockLocal.cacheUser(any()))
          .thenAnswer((_) async {});

      // Act
      final result = await repository.getUser(testId);

      // Assert
      expect(result.id, equals(testId));
      expect(result.name, equals('Test User'));
      verify(() => mockLocal.cacheUser(testUserModel)).called(1);
    });

    test('returns cached user when remote fails', () async {
      // Arrange
      when(() => mockRemote.getUser(testId))
          .thenThrow(NetworkException());
      when(() => mockLocal.getUser(testId))
          .thenAnswer((_) async => testUserModel);

      // Act
      final result = await repository.getUser(testId);

      // Assert
      expect(result.id, equals(testId));
      verify(() => mockLocal.getUser(testId)).called(1);
    });

    test('throws when both remote and local fail', () async {
      // Arrange
      when(() => mockRemote.getUser(testId))
          .thenThrow(NetworkException());
      when(() => mockLocal.getUser(testId))
          .thenThrow(CacheException());

      // Act & Assert
      expect(
        () => repository.getUser(testId),
        throwsA(isA<UserNotFoundException>()),
      );
    });
  });
}
```

---

## Testing Use Cases

```dart
// test/domain/usecases/get_user_profile_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}
class MockAnalyticsService extends Mock implements AnalyticsService {}

void main() {
  late GetUserProfile useCase;
  late MockUserRepository mockRepository;
  late MockAnalyticsService mockAnalytics;

  setUp(() {
    mockRepository = MockUserRepository();
    mockAnalytics = MockAnalyticsService();
    useCase = GetUserProfile(
      repository: mockRepository,
      analytics: mockAnalytics,
    );
  });

  test('returns user profile and logs analytics', () async {
    // Arrange
    final user = User(id: '1', name: 'Test', email: 'test@test.com');
    when(() => mockRepository.getUser('1'))
        .thenAnswer((_) async => user);
    when(() => mockAnalytics.logEvent(any(), any()))
        .thenAnswer((_) async {});

    // Act
    final result = await useCase.execute('1');

    // Assert
    expect(result, equals(user));
    verify(() => mockAnalytics.logEvent('profile_viewed', {'user_id': '1'}))
        .called(1);
  });

  test('does not log analytics on failure', () async {
    // Arrange
    when(() => mockRepository.getUser(any()))
        .thenThrow(Exception('Not found'));

    // Act & Assert
    expect(() => useCase.execute('1'), throwsException);
    verifyNever(() => mockAnalytics.logEvent(any(), any()));
  });
}
```

---

## Testing Models

```dart
// test/data/models/user_model_test.dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserModel', () {
    const testJson = {
      'id': '123',
      'email': 'test@test.com',
      'name': 'Test User',
      'created_at': '2024-01-15T10:30:00Z',
    };

    group('fromJson', () {
      test('creates valid model from JSON', () {
        final model = UserModel.fromJson(testJson);

        expect(model.id, equals('123'));
        expect(model.email, equals('test@test.com'));
        expect(model.name, equals('Test User'));
        expect(model.createdAt, isA<DateTime>());
      });

      test('handles null optional fields', () {
        final jsonWithNulls = {
          'id': '123',
          'email': 'test@test.com',
          'name': null,
          'created_at': '2024-01-15T10:30:00Z',
        };

        final model = UserModel.fromJson(jsonWithNulls);

        expect(model.name, isNull);
      });

      test('throws FormatException for invalid date', () {
        final invalidJson = {
          ...testJson,
          'created_at': 'invalid-date',
        };

        expect(
          () => UserModel.fromJson(invalidJson),
          throwsFormatException,
        );
      });
    });

    group('toJson', () {
      test('returns valid JSON map', () {
        final model = UserModel(
          id: '123',
          email: 'test@test.com',
          name: 'Test User',
          createdAt: DateTime.utc(2024, 1, 15, 10, 30),
        );

        final json = model.toJson();

        expect(json['id'], equals('123'));
        expect(json['email'], equals('test@test.com'));
        expect(json['created_at'], equals('2024-01-15T10:30:00.000Z'));
      });
    });

    group('toEntity', () {
      test('converts to User entity', () {
        final model = UserModel.fromJson(testJson);
        final entity = model.toEntity();

        expect(entity, isA<User>());
        expect(entity.id, equals(model.id));
        expect(entity.email, equals(model.email));
      });
    });

    group('equality', () {
      test('two models with same id are equal', () {
        final model1 = UserModel(id: '1', email: 'a@a.com', name: 'A');
        final model2 = UserModel(id: '1', email: 'b@b.com', name: 'B');

        expect(model1, equals(model2));
      });

      test('two models with different id are not equal', () {
        final model1 = UserModel(id: '1', email: 'a@a.com', name: 'A');
        final model2 = UserModel(id: '2', email: 'a@a.com', name: 'A');

        expect(model1, isNot(equals(model2)));
      });
    });
  });
}
```

---

## Testing Pure Functions / Utilities

```dart
// test/core/utils/validators_test.dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EmailValidator', () {
    test('returns true for valid email', () {
      expect(EmailValidator.isValid('test@example.com'), isTrue);
      expect(EmailValidator.isValid('user.name@domain.org'), isTrue);
      expect(EmailValidator.isValid('user+tag@example.co.uk'), isTrue);
    });

    test('returns false for invalid email', () {
      expect(EmailValidator.isValid(''), isFalse);
      expect(EmailValidator.isValid('invalid'), isFalse);
      expect(EmailValidator.isValid('no@domain'), isFalse);
      expect(EmailValidator.isValid('@nodomain.com'), isFalse);
      expect(EmailValidator.isValid('spaces in@email.com'), isFalse);
    });
  });

  group('PasswordValidator', () {
    test('returns true for strong password', () {
      expect(PasswordValidator.isStrong('Abcd1234!'), isTrue);
      expect(PasswordValidator.isStrong('MyP@ssw0rd'), isTrue);
    });

    test('returns false for weak password', () {
      expect(PasswordValidator.isStrong('short'), isFalse);
      expect(PasswordValidator.isStrong('nouppercase1!'), isFalse);
      expect(PasswordValidator.isStrong('NOLOWERCASE1!'), isFalse);
      expect(PasswordValidator.isStrong('NoNumbers!'), isFalse);
      expect(PasswordValidator.isStrong('NoSpecial123'), isFalse);
    });
  });

  group('CurrencyFormatter', () {
    test('formats positive amounts', () {
      expect(CurrencyFormatter.format(1234.56), equals('\$1,234.56'));
      expect(CurrencyFormatter.format(0.99), equals('\$0.99'));
      expect(CurrencyFormatter.format(1000000), equals('\$1,000,000.00'));
    });

    test('formats negative amounts', () {
      expect(CurrencyFormatter.format(-50.00), equals('-\$50.00'));
    });

    test('handles zero', () {
      expect(CurrencyFormatter.format(0), equals('\$0.00'));
    });
  });
}
```

---

## Mocking Patterns

### Basic Mock Setup
```dart
class MockApiService extends Mock implements ApiService {}

void main() {
  late MockApiService mockApi;

  setUp(() {
    mockApi = MockApiService();
  });

  // Tests...
}
```

### Stubbing Return Values
```dart
// Return a value
when(() => mockApi.getUser(any()))
    .thenReturn(User(id: '1', name: 'Test'));

// Return a Future
when(() => mockApi.fetchData())
    .thenAnswer((_) async => ['item1', 'item2']);

// Return different values on successive calls
when(() => mockApi.getNext())
    .thenReturn('first')
    .thenReturn('second')
    .thenReturn('third');
```

### Stubbing Errors
```dart
// Throw exception
when(() => mockApi.fetchData())
    .thenThrow(NetworkException());

// Throw on specific argument
when(() => mockApi.getUser('invalid'))
    .thenThrow(NotFoundException());
```

### Verifying Calls
```dart
// Verify called once
verify(() => mockApi.save(any())).called(1);

// Verify called multiple times
verify(() => mockApi.log(any())).called(3);

// Verify never called
verifyNever(() => mockApi.delete(any()));

// Verify call order
verifyInOrder([
  () => mockApi.start(),
  () => mockApi.process(),
  () => mockApi.finish(),
]);
```

### Capturing Arguments
```dart
test('captures the saved todo', () async {
  final capturedTodo = verify(() => mockRepo.save(captureAny()))
      .captured
      .first as Todo;

  expect(capturedTodo.title, equals('Expected Title'));
});
```

---

## Test Helpers

```dart
// test/helpers/test_helpers.dart

/// Creates a test user with optional overrides
User createTestUser({
  String id = '1',
  String name = 'Test User',
  String email = 'test@test.com',
}) {
  return User(id: id, name: name, email: email);
}

/// Creates a list of test todos
List<Todo> createTestTodos(int count) {
  return List.generate(
    count,
    (i) => Todo(id: '$i', title: 'Todo $i'),
  );
}
```

---

## Common Assertions

```dart
// Equality
expect(result, equals(expected));
expect(result, isNot(equals(other)));

// Type checking
expect(result, isA<User>());
expect(result, isA<String>());

// Collection assertions
expect(list, isEmpty);
expect(list, isNotEmpty);
expect(list, hasLength(5));
expect(list, contains(item));
expect(list, containsAll([item1, item2]));

// Null checking
expect(result, isNull);
expect(result, isNotNull);

// Boolean
expect(result, isTrue);
expect(result, isFalse);

// Numeric
expect(result, greaterThan(5));
expect(result, lessThan(10));
expect(result, inInclusiveRange(1, 10));

// String
expect(str, startsWith('Hello'));
expect(str, endsWith('World'));
expect(str, contains('middle'));
expect(str, matches(RegExp(r'\d+')));

// Exception
expect(() => throwingFunction(), throwsException);
expect(() => throwingFunction(), throwsA(isA<CustomException>()));
expect(
  () => throwingFunction(),
  throwsA(
    isA<CustomException>().having((e) => e.message, 'message', 'Expected'),
  ),
);
```
