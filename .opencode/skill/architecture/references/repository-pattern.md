# Repository Pattern

## Interface Definition

```dart
// domain/repositories/user_repository.dart
abstract class UserRepository {
  Future<User> getUser(String id);
  Future<List<User>> getUsers();
  Future<void> updateUser(User user);
  Future<void> deleteUser(String id);
}
```

## Implementation with Cache

```dart
// data/repositories/user_repository_impl.dart
class UserRepositoryImpl implements UserRepository {
  final UserRemoteSource _remoteSource;
  final UserLocalSource _localSource;
  final NetworkInfo _networkInfo;

  UserRepositoryImpl({
    required UserRemoteSource remoteSource,
    required UserLocalSource localSource,
    required NetworkInfo networkInfo,
  })  : _remoteSource = remoteSource,
        _localSource = localSource,
        _networkInfo = networkInfo;

  @override
  Future<User> getUser(String id) async {
    if (await _networkInfo.isConnected) {
      try {
        final user = await _remoteSource.getUser(id);
        await _localSource.cacheUser(user);
        return user;
      } catch (e) {
        return _localSource.getCachedUser(id);
      }
    } else {
      return _localSource.getCachedUser(id);
    }
  }

  @override
  Future<void> updateUser(User user) async {
    // Optimistic update: update local first
    await _localSource.cacheUser(user);
    
    try {
      await _remoteSource.updateUser(user);
    } catch (e) {
      // Queue for later sync if offline
      await _localSource.queueForSync(user);
      rethrow;
    }
  }
}
```

## Data Sources

### Remote Source

```dart
// data/datasources/user_remote_source.dart
class UserRemoteSource {
  final ApiClient _client;

  UserRemoteSource({required ApiClient client}) : _client = client;

  Future<UserModel> getUser(String id) async {
    final response = await _client.get('/users/$id');
    return UserModel.fromJson(response.data);
  }

  Future<List<UserModel>> getUsers() async {
    final response = await _client.get('/users');
    return (response.data as List)
        .map((json) => UserModel.fromJson(json))
        .toList();
  }

  Future<void> updateUser(User user) async {
    await _client.put('/users/${user.id}', data: user.toJson());
  }
}
```

### Local Source

```dart
// data/datasources/user_local_source.dart
class UserLocalSource {
  final SharedPreferences _prefs;
  
  static const _cachedUserKey = 'CACHED_USER';

  UserLocalSource({required SharedPreferences prefs}) : _prefs = prefs;

  Future<void> cacheUser(UserModel user) async {
    await _prefs.setString(_cachedUserKey, jsonEncode(user.toJson()));
  }

  Future<UserModel> getCachedUser(String id) async {
    final jsonString = _prefs.getString(_cachedUserKey);
    if (jsonString == null) {
      throw CacheException('No cached user found');
    }
    return UserModel.fromJson(jsonDecode(jsonString));
  }
}
```

## Error Handling with Result Type

```dart
// core/error/result.dart
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final AppFailure failure;
  const Failure(this.failure);
}

// core/error/failures.dart
sealed class AppFailure {
  final String message;
  const AppFailure(this.message);
}

class NetworkFailure extends AppFailure {
  const NetworkFailure([super.message = 'Network error']);
}

class CacheFailure extends AppFailure {
  const CacheFailure([super.message = 'Cache error']);
}

class ServerFailure extends AppFailure {
  const ServerFailure([super.message = 'Server error']);
}
```

### Repository with Result

```dart
// domain/repositories/user_repository.dart
abstract class UserRepository {
  Future<Result<User>> getUser(String id);
}

// data/repositories/user_repository_impl.dart
class UserRepositoryImpl implements UserRepository {
  @override
  Future<Result<User>> getUser(String id) async {
    try {
      if (await _networkInfo.isConnected) {
        final user = await _remoteSource.getUser(id);
        await _localSource.cacheUser(user);
        return Success(user);
      } else {
        final user = await _localSource.getCachedUser(id);
        return Success(user);
      }
    } on NetworkException {
      return const Failure(NetworkFailure());
    } on CacheException {
      return const Failure(CacheFailure());
    } catch (e) {
      return Failure(ServerFailure(e.toString()));
    }
  }
}
```

### Using in BLoC

```dart
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _repository;

  UserBloc({required UserRepository repository})
      : _repository = repository,
        super(UserInitial()) {
    on<LoadUser>(_onLoadUser);
  }

  Future<void> _onLoadUser(LoadUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    
    final result = await _repository.getUser(event.userId);
    
    switch (result) {
      case Success(:final data):
        emit(UserLoaded(data));
      case Failure(:final failure):
        emit(UserError(failure.message));
    }
  }
}
```

## Testing Repositories

```dart
void main() {
  late UserRepositoryImpl repository;
  late MockUserRemoteSource mockRemoteSource;
  late MockUserLocalSource mockLocalSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteSource = MockUserRemoteSource();
    mockLocalSource = MockUserLocalSource();
    mockNetworkInfo = MockNetworkInfo();
    
    repository = UserRepositoryImpl(
      remoteSource: mockRemoteSource,
      localSource: mockLocalSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getUser', () {
    const testId = '123';
    final testUser = UserModel(id: testId, name: 'Test', email: 'test@test.com');

    test('returns remote data when online', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteSource.getUser(testId))
          .thenAnswer((_) async => testUser);
      when(() => mockLocalSource.cacheUser(testUser))
          .thenAnswer((_) async {});

      // Act
      final result = await repository.getUser(testId);

      // Assert
      expect(result, isA<Success<User>>());
      expect((result as Success).data.id, equals(testId));
      verify(() => mockLocalSource.cacheUser(testUser)).called(1);
    });

    test('returns cached data when offline', () async {
      // Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(() => mockLocalSource.getCachedUser(testId))
          .thenAnswer((_) async => testUser);

      // Act
      final result = await repository.getUser(testId);

      // Assert
      expect(result, isA<Success<User>>());
      verifyNever(() => mockRemoteSource.getUser(any()));
    });
  });
}
```
