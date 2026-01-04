# Feature-First Project Structure

## Complete Structure

```
lib/
├── main.dart                          # Entry point with ProviderScope
├── app.dart                           # MaterialApp configuration
│
├── core/                              # Shared across ALL features
│   ├── providers/                     # Core Riverpod providers
│   │   ├── api_client_provider.dart
│   │   ├── secure_storage_provider.dart
│   │   └── shared_preferences_provider.dart
│   │
│   ├── network/
│   │   ├── api_client.dart            # HTTP client (Dio)
│   │   ├── api_endpoints.dart         # URL constants
│   │   └── interceptors/
│   │       ├── auth_interceptor.dart
│   │       └── logging_interceptor.dart
│   │
│   ├── error/
│   │   ├── failures.dart              # Failure types
│   │   └── exceptions.dart            # Exception types
│   │
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── app_colors.dart
│   │   └── app_text_styles.dart
│   │
│   ├── utils/
│   │   ├── validators.dart
│   │   └── formatters.dart
│   │
│   └── widgets/                       # ONLY if used by 3+ features
│       ├── loading_indicator.dart
│       └── error_view.dart
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── auth_remote_source.dart
│   │   │   │   └── auth_local_source.dart
│   │   │   ├── models/
│   │   │   │   └── user_model.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository_impl.dart
│   │   │   └── providers/
│   │   │       └── auth_repository_provider.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   └── auth_provider.dart
│   │       ├── screens/
│   │       │   ├── login_screen.dart
│   │       │   └── register_screen.dart
│   │       └── widgets/
│   │           ├── login_form.dart
│   │           └── social_login_button.dart
│   │
│   ├── home/
│   │   ├── data/
│   │   │   ├── providers/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   └── presentation/
│   │       └── providers/
│   │
│   └── profile/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
└── config/
    ├── routes.dart                    # go_router configuration
    └── environment.dart               # Environment-specific config
```

## Test Structure (Mirrors lib/)

```
test/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── auth_remote_source_test.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl_test.dart
│   │   ├── domain/
│   │   │   └── usecases/
│   │   │       └── login_usecase_test.dart
│   │   └── presentation/
│   │       └── providers/
│   │           └── auth_provider_test.dart
│   └── home/
│       └── ...
├── core/
│   └── network/
│       └── api_client_test.dart
└── helpers/
    ├── pump_app.dart                  # Test wrappers with ProviderScope
    ├── mocks.dart                     # Shared mocks
    └── fixtures.dart                  # Test data
```

## Entry Point

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

## Layer Responsibilities

### Domain Layer (innermost, no dependencies)

| Component | Responsibility |
|-----------|---------------|
| **Entity** | Pure business object, no framework imports |
| **Repository Interface** | Contract for data operations |

```dart
// domain/entities/user.dart
class User {
  final String id;
  final String email;
  final String name;

  const User({required this.id, required this.email, required this.name});
}

// domain/repositories/auth_repository.dart
abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<void> logout();
  Future<User?> getCurrentUser();
}
```

### Data Layer (depends on domain)

| Component | Responsibility |
|-----------|---------------|
| **Model** | DTO with JSON serialization |
| **DataSource** | API calls, database queries |
| **Repository Impl** | Implements interface, coordinates sources |
| **Providers** | Riverpod providers for repositories |

```dart
// data/models/user_model.dart
class UserModel extends User {
  const UserModel({required super.id, required super.email, required super.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'email': email, 'name': name};
}

// data/providers/auth_repository_provider.dart
@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    remoteSource: ref.watch(authRemoteSourceProvider),
    localSource: ref.watch(authLocalSourceProvider),
  );
}
```

### Presentation Layer (depends on domain)

| Component | Responsibility |
|-----------|---------------|
| **Providers** | State management (Riverpod Notifiers) |
| **Screen** | Page-level widget (ConsumerWidget) |
| **Widget** | Reusable UI component within feature |

```dart
// presentation/providers/auth_provider.dart
@riverpod
class Auth extends _$Auth {
  @override
  FutureOr<User?> build() async {
    return ref.watch(authRepositoryProvider).getCurrentUser();
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ref.read(authRepositoryProvider).login(email, password);
    });
  }
}

// presentation/screens/login_screen.dart
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    
    return authState.when(
      data: (user) => user != null 
          ? const HomeScreen() 
          : const LoginForm(),
      loading: () => const LoadingIndicator(),
      error: (e, _) => ErrorView(message: e.toString()),
    );
  }
}
```

## When to Create a New Feature

| Signal | Action |
|--------|--------|
| Distinct user flow (checkout, settings) | New feature folder |
| 5+ related screens | New feature folder |
| Independent from other features | New feature folder |
| Shared by multiple features | Move to `core/` |

## Feature Communication

Features should NOT directly depend on each other. Use:

```dart
// Option 1: Watch a shared provider
// Both features depend on core auth state
final user = ref.watch(authProvider);

// Option 2: Navigation with data passing
context.go('/profile', extra: userId);

// Option 3: Shared core providers
// core/providers/app_state_provider.dart
@Riverpod(keepAlive: true)
class AppState extends _$AppState {
  @override
  AppStateData build() => AppStateData.initial();
  
  void setSelectedUserId(String id) {
    state = state.copyWith(selectedUserId: id);
  }
}
```

## Alternative: BLoC Structure

For features using BLoC pattern, use this structure:

```
features/auth/
└── presentation/
    ├── bloc/                          # Instead of providers/
    │   ├── auth_bloc.dart
    │   ├── auth_event.dart
    │   └── auth_state.dart
    ├── screens/
    └── widgets/
```

With GetIt for DI (see [dependency-injection.md](dependency-injection.md)).
