# Riverpod

## Dependencies

```yaml
dependencies:
  flutter_riverpod: ^3.1.0
  riverpod_annotation: ^3.0.3

dev_dependencies:
  riverpod_generator: ^3.0.3
  build_runner: ^2.4.0
```

```bash
# Generate provider code
dart run build_runner build --delete-conflicting-outputs

# Watch mode during development
dart run build_runner watch --delete-conflicting-outputs
```

## Setup

```dart
// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
```

## Provider Types Decision

| Need | Provider Type | Code Gen |
|------|---------------|----------|
| Sync computed value | `Provider` | `@riverpod` function |
| Mutable state with logic | `NotifierProvider` | `@riverpod` class |
| Async data (API call) | `FutureProvider` | `@riverpod Future<T>` |
| Real-time stream | `StreamProvider` | `@riverpod Stream<T>` |
| Mutable async state | `AsyncNotifierProvider` | `@riverpod` class with async |
| Parameterized (by ID) | Family | Add parameters to function |

## Code Generation (Recommended)

### Sync Provider

```dart
// features/settings/presentation/providers/theme_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
ThemeMode themeMode(Ref ref) {
  return ThemeMode.system;
}

// Generated: themeModeProvider
// Usage: ref.watch(themeModeProvider)
```

### Notifier (Mutable State)

```dart
// features/counter/presentation/providers/counter_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_provider.g.dart';

@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;

  void increment() => state++;
  void decrement() => state--;
  void reset() => state = 0;
}

// Generated: counterProvider
// Usage: 
//   ref.watch(counterProvider)           // Get value
//   ref.read(counterProvider.notifier).increment()  // Call method
```

### Async Notifier (Feature State)

```dart
// features/auth/presentation/providers/auth_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  FutureOr<User?> build() async {
    // Initial load - check for existing session
    final authRepo = ref.watch(authRepositoryProvider);
    return authRepo.getCurrentUser();
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final authRepo = ref.read(authRepositoryProvider);
      return authRepo.login(email, password);
    });
  }

  Future<void> logout() async {
    final authRepo = ref.read(authRepositoryProvider);
    await authRepo.logout();
    state = const AsyncData(null);
  }
}

// Generated: authProvider
// Usage:
//   ref.watch(authProvider)              // AsyncValue<User?>
//   ref.read(authProvider.notifier).login(email, password)
```

### Future Provider (Read-Only Async)

```dart
// features/products/presentation/providers/products_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_provider.g.dart';

@riverpod
Future<List<Product>> products(Ref ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProducts();
}

// Auto-disposes when no longer watched
// Use @Riverpod(keepAlive: true) to persist
```

### Family (Parameterized)

```dart
// features/users/presentation/providers/user_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
Future<User> user(Ref ref, {required String userId}) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getUser(userId);
}

// Usage: ref.watch(userProvider(userId: '123'))
```

### Keep Alive (Persist State)

```dart
@Riverpod(keepAlive: true)
class AppSettings extends _$AppSettings {
  @override
  Settings build() => Settings.defaults();
  
  void updateLocale(Locale locale) {
    state = state.copyWith(locale: locale);
  }
}
```

## Consuming Providers

### ConsumerWidget

```dart
class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return authState.when(
      data: (user) => user != null 
          ? ProfileView(user: user)
          : const LoginPrompt(),
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => ErrorView(message: error.toString()),
    );
  }
}
```

### ConsumerStatefulWidget

```dart
class CounterScreen extends ConsumerStatefulWidget {
  const CounterScreen({super.key});

  @override
  ConsumerState<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends ConsumerState<CounterScreen> {
  @override
  void initState() {
    super.initState();
    // Access ref in lifecycle methods
    ref.read(analyticsProvider).logScreenView('counter');
  }

  @override
  Widget build(BuildContext context) {
    final count = ref.watch(counterProvider);
    
    return Scaffold(
      body: Center(child: Text('Count: $count')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### ref.watch vs ref.read

| Method | Rebuilds Widget | Use Case |
|--------|-----------------|----------|
| `ref.watch(provider)` | Yes | In `build()` method |
| `ref.read(provider)` | No | In callbacks, event handlers |
| `ref.listen(provider, callback)` | No | Side effects (snackbar, navigation) |

```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  // Listen for side effects
  ref.listen(authProvider, (prev, next) {
    next.whenOrNull(
      error: (error, _) => ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString()))),
    );
  });

  // Watch for rebuilds
  final user = ref.watch(authProvider);
  
  return ElevatedButton(
    // Read in callback (no rebuild needed)
    onPressed: () => ref.read(authProvider.notifier).logout(),
    child: const Text('Logout'),
  );
}
```

### Select (Granular Rebuilds)

```dart
// Only rebuild when user's name changes
final userName = ref.watch(
  authProvider.select((state) => state.valueOrNull?.name),
);
```

## Dependency Injection with Riverpod

Providers can depend on other providers via `ref`:

```dart
// core/providers/api_client_provider.dart
@riverpod
ApiClient apiClient(Ref ref) {
  return ApiClient(baseUrl: 'https://api.example.com');
}

// features/auth/data/providers/auth_repository_provider.dart
@riverpod
AuthRepository authRepository(Ref ref) {
  final client = ref.watch(apiClientProvider);
  final storage = ref.watch(secureStorageProvider);
  return AuthRepositoryImpl(client: client, storage: storage);
}

// features/auth/presentation/providers/auth_provider.dart
@riverpod
class Auth extends _$Auth {
  @override
  FutureOr<User?> build() async {
    // Automatic dependency on authRepositoryProvider
    final repo = ref.watch(authRepositoryProvider);
    return repo.getCurrentUser();
  }
}
```

## Testing

### Unit Testing Providers

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late ProviderContainer container;
  late MockAuthRepository mockAuthRepo;

  setUp(() {
    mockAuthRepo = MockAuthRepository();
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(mockAuthRepo),
      ],
    );
    addTearDown(container.dispose);
  });

  test('auth provider returns current user on build', () async {
    final testUser = User(id: '1', name: 'Test');
    when(() => mockAuthRepo.getCurrentUser())
        .thenAnswer((_) async => testUser);

    // Wait for async provider to complete
    await container.read(authProvider.future);
    
    final state = container.read(authProvider);
    expect(state.valueOrNull, equals(testUser));
  });

  test('login updates state to authenticated', () async {
    final testUser = User(id: '1', name: 'Test');
    when(() => mockAuthRepo.getCurrentUser())
        .thenAnswer((_) async => null);
    when(() => mockAuthRepo.login(any(), any()))
        .thenAnswer((_) async => testUser);

    await container.read(authProvider.future);
    await container.read(authProvider.notifier).login('test@test.com', 'pass');

    final state = container.read(authProvider);
    expect(state.valueOrNull, equals(testUser));
  });
}
```

### Widget Testing

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('shows user name when authenticated', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authProvider.overrideWith(() => MockAuthNotifier()),
        ],
        child: const MaterialApp(home: UserProfileScreen()),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Test User'), findsOneWidget);
  });
}

class MockAuthNotifier extends Auth {
  @override
  FutureOr<User?> build() => User(id: '1', name: 'Test User');
}
```

## Common Patterns

### Loading/Error/Success with AsyncValue

```dart
final productsAsync = ref.watch(productsProvider);

return productsAsync.when(
  data: (products) => ProductList(products: products),
  loading: () => const ProductListSkeleton(),
  error: (error, stack) => ErrorRetry(
    message: error.toString(),
    onRetry: () => ref.invalidate(productsProvider),
  ),
);

// Or with switch expression
return switch (productsAsync) {
  AsyncData(:final value) => ProductList(products: value),
  AsyncError(:final error) => Text('Error: $error'),
  _ => const CircularProgressIndicator(),
};
```

### Refresh/Invalidate

```dart
// Invalidate - re-run build() on next read
ref.invalidate(productsProvider);

// Refresh - invalidate and immediately re-fetch
await ref.refresh(productsProvider.future);
```

### Combining Providers

```dart
@riverpod
Future<DashboardData> dashboard(Ref ref) async {
  // Wait for multiple providers in parallel
  final results = await Future.wait([
    ref.watch(userProvider.future),
    ref.watch(statsProvider.future),
    ref.watch(notificationsProvider.future),
  ]);
  
  return DashboardData(
    user: results[0] as User,
    stats: results[1] as Stats,
    notifications: results[2] as List<Notification>,
  );
}
```

### Debouncing (Search)

```dart
@riverpod
class SearchNotifier extends _$SearchNotifier {
  Timer? _debounce;

  @override
  AsyncValue<List<Product>> build() => const AsyncData([]);

  void search(String query) {
    _debounce?.cancel();
    
    if (query.isEmpty) {
      state = const AsyncData([]);
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 300), () async {
      state = const AsyncLoading();
      state = await AsyncValue.guard(() async {
        final repo = ref.read(productRepositoryProvider);
        return repo.search(query);
      });
    });
  }
}
```

## Anti-Patterns

| Avoid | Instead |
|-------|---------|
| `ref.read` in `build()` | Use `ref.watch` for reactive updates |
| Business logic in widgets | Move to Notifier classes |
| Manual state without Notifier | Use `NotifierProvider` for mutable state |
| Nested `ProviderScope` (usually) | Single root scope, use overrides for testing |
| `StateProvider` for complex state | Use `NotifierProvider` |
