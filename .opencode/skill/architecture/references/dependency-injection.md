# Dependency Injection with Riverpod

Riverpod provides built-in dependency injection through the `ref` system. Providers automatically track their dependencies, enabling compile-time safety and automatic disposal.

## Core Concept

```dart
// Dependencies are declared via ref.watch/ref.read
@riverpod
AuthRepository authRepository(Ref ref) {
  final client = ref.watch(apiClientProvider);      // Dependency 1
  final storage = ref.watch(secureStorageProvider); // Dependency 2
  return AuthRepositoryImpl(client: client, storage: storage);
}

// When apiClientProvider or secureStorageProvider changes,
// authRepositoryProvider automatically rebuilds
```

## Provider Organization

### Core Providers (Shared Services)

```dart
// core/providers/api_client_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client_provider.g.dart';

@Riverpod(keepAlive: true)  // Persist across app lifetime
ApiClient apiClient(Ref ref) {
  return ApiClient(baseUrl: 'https://api.example.com');
}
```

```dart
// core/providers/secure_storage_provider.dart
@Riverpod(keepAlive: true)
SecureStorage secureStorage(Ref ref) {
  return SecureStorage();
}
```

```dart
// core/providers/shared_preferences_provider.dart
@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  return SharedPreferences.getInstance();
}
```

### Feature Providers (Per-Feature)

```dart
// features/auth/data/providers/auth_repository_provider.dart
@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    client: ref.watch(apiClientProvider),
    storage: ref.watch(secureStorageProvider),
  );
}

// features/auth/presentation/providers/auth_provider.dart
@riverpod
class Auth extends _$Auth {
  @override
  FutureOr<User?> build() async {
    final repo = ref.watch(authRepositoryProvider);
    return repo.getCurrentUser();
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ref.read(authRepositoryProvider).login(email, password);
    });
  }
}
```

## Provider Lifecycle

| Annotation | Lifecycle | Use Case |
|------------|-----------|----------|
| `@riverpod` | Auto-dispose when unused | Most providers |
| `@Riverpod(keepAlive: true)` | Persist forever | Core services, singletons |

```dart
// Auto-dispose: Disposes when no widget watches it
@riverpod
Future<User> user(Ref ref, {required String userId}) async {
  return ref.watch(userRepositoryProvider).getUser(userId);
}

// Keep alive: Never disposes (like GetIt singleton)
@Riverpod(keepAlive: true)
AnalyticsService analytics(Ref ref) {
  return AnalyticsService();
}
```

## Dependency Graph

```
┌─────────────────────────────────────────────────────────────┐
│                      CORE PROVIDERS                          │
│  ┌──────────────┐  ┌─────────────────┐  ┌────────────────┐  │
│  │ apiClient    │  │ secureStorage   │  │ sharedPrefs    │  │
│  │ (keepAlive)  │  │ (keepAlive)     │  │ (keepAlive)    │  │
│  └──────┬───────┘  └────────┬────────┘  └───────┬────────┘  │
└─────────┼───────────────────┼───────────────────┼───────────┘
          │                   │                   │
          ▼                   ▼                   ▼
┌─────────────────────────────────────────────────────────────┐
│                    FEATURE PROVIDERS                         │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ authRepository (depends on apiClient, secureStorage) │   │
│  └────────────────────────┬─────────────────────────────┘   │
│                           │                                  │
│  ┌────────────────────────▼─────────────────────────────┐   │
│  │ authProvider (depends on authRepository)              │   │
│  │ [AsyncNotifier - manages auth state]                  │   │
│  └───────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

## ref Methods

| Method | Rebuilds | Use Case |
|--------|----------|----------|
| `ref.watch(provider)` | Yes | Dependencies that should trigger rebuild |
| `ref.read(provider)` | No | One-time access in methods |
| `ref.listen(provider, callback)` | No | React to changes without rebuilding |
| `ref.invalidate(provider)` | N/A | Force provider to rebuild |

```dart
@riverpod
class Auth extends _$Auth {
  @override
  FutureOr<User?> build() async {
    // WATCH: Rebuild auth when repository changes
    final repo = ref.watch(authRepositoryProvider);
    
    // LISTEN: Log analytics on auth state changes
    ref.listen(authRepositoryProvider, (prev, next) {
      ref.read(analyticsProvider).log('repo_changed');
    });
    
    return repo.getCurrentUser();
  }

  Future<void> login(String email, String password) async {
    // READ: One-time access in method (no rebuild needed)
    final repo = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => repo.login(email, password));
  }
}
```

## Testing with Overrides

Riverpod's DI shines in testing - no setup/teardown of service locators:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('AuthProvider', () {
    late ProviderContainer container;
    late MockAuthRepository mockAuthRepo;

    setUp(() {
      mockAuthRepo = MockAuthRepository();
      container = ProviderContainer(
        overrides: [
          // Override repository with mock
          authRepositoryProvider.overrideWithValue(mockAuthRepo),
        ],
      );
      addTearDown(container.dispose);
    });

    test('returns user on successful login', () async {
      final testUser = User(id: '1', name: 'Test');
      when(() => mockAuthRepo.getCurrentUser())
          .thenAnswer((_) async => null);
      when(() => mockAuthRepo.login(any(), any()))
          .thenAnswer((_) async => testUser);

      // Initial build
      await container.read(authProvider.future);
      
      // Call login
      await container.read(authProvider.notifier).login('test@test.com', 'pass');

      expect(container.read(authProvider).valueOrNull, equals(testUser));
      verify(() => mockAuthRepo.login('test@test.com', 'pass')).called(1);
    });
  });
}
```

### Widget Testing

```dart
testWidgets('shows login button when unauthenticated', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authProvider.overrideWith(() => MockAuthNotifier()),
      ],
      child: const MaterialApp(home: AuthScreen()),
    ),
  );

  expect(find.text('Login'), findsOneWidget);
});

class MockAuthNotifier extends Auth {
  @override
  FutureOr<User?> build() => null; // Unauthenticated
}
```

## Scoped Providers

For feature-scoped dependencies (e.g., form state):

```dart
// Provider that requires external value
@riverpod
class ProductEditor extends _$ProductEditor {
  @override
  Product build(Product initial) => initial;

  void updateName(String name) {
    state = state.copyWith(name: name);
  }
}

// Usage with ProviderScope override
class EditProductScreen extends StatelessWidget {
  final Product product;

  const EditProductScreen({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        productEditorProvider.overrideWith(
          () => ProductEditor()..state = product,
        ),
      ],
      child: const EditProductView(),
    );
  }
}
```

## Migration from GetIt

| GetIt | Riverpod Equivalent |
|-------|---------------------|
| `sl.registerSingleton<T>(instance)` | `@Riverpod(keepAlive: true)` |
| `sl.registerLazySingleton<T>(() => ...)` | `@Riverpod(keepAlive: true)` (lazy by default) |
| `sl.registerFactory<T>(() => ...)` | `@riverpod` (auto-dispose) |
| `sl<T>()` | `ref.watch(provider)` or `ref.read(provider)` |
| `sl.reset()` | `container.dispose()` in tests |

## Alternative: GetIt for BLoC Projects

If using BLoC pattern (see [bloc.md](../../state-management/references/bloc.md)), you may prefer GetIt for service location:

```dart
// core/di/injection.dart
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  // Core
  sl.registerLazySingleton<ApiClient>(() => ApiClient());
  
  // Features
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(client: sl()),
  );
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(repository: sl()),
  );
}
```

This approach is fine for BLoC-heavy codebases. For new projects, Riverpod's integrated DI is recommended.

## Anti-Patterns

| Avoid | Instead |
|-------|---------|
| Passing `ref` to classes | Inject dependencies directly |
| `ref.read` in `build()` of provider | Use `ref.watch` for reactivity |
| Manual lifecycle management | Let Riverpod handle disposal |
| Circular dependencies | Restructure provider hierarchy |
| Overusing `keepAlive` | Only for true singletons |
