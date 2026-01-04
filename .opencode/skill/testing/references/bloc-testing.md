# BLoC Testing

Testing BLoC (Business Logic Component) and Cubit state management.

## Setup

```yaml
# pubspec.yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: ^9.1.0
  mocktail: ^1.0.0
```

---

## Testing Cubit

Cubits are simpler than BLoCs - they emit states directly without events.

### Basic Cubit Test

```dart
// lib/presentation/cubit/counter_cubit.dart
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
  void reset() => emit(0);
}
```

```dart
// test/presentation/cubit/counter_cubit_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterCubit', () {
    test('initial state is 0', () {
      final cubit = CounterCubit();
      expect(cubit.state, equals(0));
      cubit.close();
    });

    blocTest<CounterCubit, int>(
      'emits [1] when increment is called',
      build: () => CounterCubit(),
      act: (cubit) => cubit.increment(),
      expect: () => [1],
    );

    blocTest<CounterCubit, int>(
      'emits [-1] when decrement is called',
      build: () => CounterCubit(),
      act: (cubit) => cubit.decrement(),
      expect: () => [-1],
    );

    blocTest<CounterCubit, int>(
      'emits [1, 2, 3] when increment is called 3 times',
      build: () => CounterCubit(),
      act: (cubit) {
        cubit.increment();
        cubit.increment();
        cubit.increment();
      },
      expect: () => [1, 2, 3],
    );

    blocTest<CounterCubit, int>(
      'emits [0] when reset is called after increment',
      build: () => CounterCubit(),
      seed: () => 5, // Start with state = 5
      act: (cubit) => cubit.reset(),
      expect: () => [0],
    );
  });
}
```

### Cubit with Dependencies

```dart
// lib/presentation/cubit/user_cubit.dart
class UserCubit extends Cubit<UserState> {
  final UserRepository repository;

  UserCubit({required this.repository}) : super(UserInitial());

  Future<void> loadUser(String id) async {
    emit(UserLoading());
    try {
      final user = await repository.getUser(id);
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
```

```dart
// test/presentation/cubit/user_cubit_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
  });

  group('UserCubit', () {
    final testUser = User(id: '1', name: 'Test User');

    blocTest<UserCubit, UserState>(
      'emits [UserLoading, UserLoaded] when loadUser succeeds',
      setUp: () {
        when(() => mockRepository.getUser(any()))
            .thenAnswer((_) async => testUser);
      },
      build: () => UserCubit(repository: mockRepository),
      act: (cubit) => cubit.loadUser('1'),
      expect: () => [
        UserLoading(),
        UserLoaded(testUser),
      ],
      verify: (_) {
        verify(() => mockRepository.getUser('1')).called(1);
      },
    );

    blocTest<UserCubit, UserState>(
      'emits [UserLoading, UserError] when loadUser fails',
      setUp: () {
        when(() => mockRepository.getUser(any()))
            .thenThrow(Exception('Network error'));
      },
      build: () => UserCubit(repository: mockRepository),
      act: (cubit) => cubit.loadUser('1'),
      expect: () => [
        UserLoading(),
        isA<UserError>(),
      ],
    );
  });
}
```

---

## Testing BLoC

BLoCs use events to trigger state changes.

### BLoC with Events

```dart
// lib/presentation/bloc/auth_bloc.dart

// Events
sealed class AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  AuthLoginRequested({required this.email, required this.password});
}

class AuthLogoutRequested extends AuthEvent {}

// States
sealed class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthAuthenticated extends AuthState {
  final User user;
  AuthAuthenticated(this.user);
}
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc({required this.repository}) : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await repository.login(event.email, event.password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await repository.logout();
    emit(AuthInitial());
  }
}
```

```dart
// test/presentation/bloc/auth_bloc_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
  });

  group('AuthBloc', () {
    final testUser = User(id: '1', email: 'test@test.com');

    test('initial state is AuthInitial', () {
      final bloc = AuthBloc(repository: mockRepository);
      expect(bloc.state, isA<AuthInitial>());
      bloc.close();
    });

    group('AuthLoginRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthAuthenticated] when login succeeds',
        setUp: () {
          when(() => mockRepository.login(any(), any()))
              .thenAnswer((_) async => testUser);
        },
        build: () => AuthBloc(repository: mockRepository),
        act: (bloc) => bloc.add(AuthLoginRequested(
          email: 'test@test.com',
          password: 'password123',
        )),
        expect: () => [
          isA<AuthLoading>(),
          isA<AuthAuthenticated>()
              .having((s) => s.user.email, 'email', 'test@test.com'),
        ],
        verify: (_) {
          verify(() => mockRepository.login('test@test.com', 'password123'))
              .called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError] when login fails',
        setUp: () {
          when(() => mockRepository.login(any(), any()))
              .thenThrow(AuthException('Invalid credentials'));
        },
        build: () => AuthBloc(repository: mockRepository),
        act: (bloc) => bloc.add(AuthLoginRequested(
          email: 'wrong@test.com',
          password: 'wrongpassword',
        )),
        expect: () => [
          isA<AuthLoading>(),
          isA<AuthError>().having(
            (s) => s.message,
            'message',
            contains('Invalid credentials'),
          ),
        ],
      );
    });

    group('AuthLogoutRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthInitial] when logout is requested',
        setUp: () {
          when(() => mockRepository.logout()).thenAnswer((_) async {});
        },
        build: () => AuthBloc(repository: mockRepository),
        seed: () => AuthAuthenticated(testUser),
        act: (bloc) => bloc.add(AuthLogoutRequested()),
        expect: () => [isA<AuthInitial>()],
        verify: (_) {
          verify(() => mockRepository.logout()).called(1);
        },
      );
    });
  });
}
```

---

## blocTest Parameters

| Parameter | Purpose | Example |
|-----------|---------|---------|
| `build` | Creates the bloc/cubit | `() => CounterCubit()` |
| `act` | Triggers actions | `(cubit) => cubit.increment()` |
| `expect` | Expected states | `() => [1, 2, 3]` |
| `seed` | Set initial state | `() => 5` |
| `setUp` | Setup before build | Configure mocks |
| `verify` | Verify after test | Check mock calls |
| `wait` | Wait duration | `Duration(milliseconds: 500)` |
| `errors` | Expected errors | `() => [isA<Exception>()]` |

---

## Testing State Equality

States should implement equality for proper testing:

```dart
// Using Equatable
class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserLoaded extends UserState {
  final User user;
  UserLoaded(this.user);

  @override
  List<Object?> get props => [user];
}
```

```dart
// Or using Freezed
@freezed
class UserState with _$UserState {
  const factory UserState.initial() = UserInitial;
  const factory UserState.loading() = UserLoading;
  const factory UserState.loaded(User user) = UserLoaded;
  const factory UserState.error(String message) = UserError;
}
```

---

## Testing Transformers

```dart
// BLoC with debounce transformer
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchQueryChanged>(
      _onQueryChanged,
      transformer: debounce(const Duration(milliseconds: 300)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  Future<void> _onQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    // Search logic
  }
}
```

```dart
// Test with wait parameter
blocTest<SearchBloc, SearchState>(
  'emits results after debounce',
  build: () => SearchBloc(),
  act: (bloc) => bloc.add(SearchQueryChanged('flutter')),
  wait: const Duration(milliseconds: 350), // Wait for debounce
  expect: () => [
    isA<SearchLoading>(),
    isA<SearchResults>(),
  ],
);
```

---

## Testing BLoC in Widgets

```dart
// test/presentation/screens/login_screen_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  Widget createWidget() {
    return MaterialApp(
      home: BlocProvider<AuthBloc>.value(
        value: mockAuthBloc,
        child: const LoginScreen(),
      ),
    );
  }

  testWidgets('shows loading indicator when state is AuthLoading',
      (tester) async {
    when(() => mockAuthBloc.state).thenReturn(AuthLoading());

    await tester.pumpWidget(createWidget());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows error message when state is AuthError', (tester) async {
    when(() => mockAuthBloc.state).thenReturn(AuthError('Login failed'));

    await tester.pumpWidget(createWidget());

    expect(find.text('Login failed'), findsOneWidget);
  });

  testWidgets('adds AuthLoginRequested event when login button tapped',
      (tester) async {
    when(() => mockAuthBloc.state).thenReturn(AuthInitial());

    await tester.pumpWidget(createWidget());

    // Enter credentials
    await tester.enterText(
      find.byKey(const Key('email-field')),
      'test@test.com',
    );
    await tester.enterText(
      find.byKey(const Key('password-field')),
      'password123',
    );

    // Tap login
    await tester.tap(find.byKey(const Key('login-button')));

    // Verify event was added
    verify(() => mockAuthBloc.add(any(that: isA<AuthLoginRequested>())))
        .called(1);
  });

  testWidgets('navigates to home when authenticated', (tester) async {
    final user = User(id: '1', email: 'test@test.com');

    // Start with initial state
    when(() => mockAuthBloc.state).thenReturn(AuthInitial());

    // Setup state stream
    whenListen(
      mockAuthBloc,
      Stream.fromIterable([AuthLoading(), AuthAuthenticated(user)]),
    );

    await tester.pumpWidget(createWidget());
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
```

---

## Testing Side Effects (BlocListener)

```dart
testWidgets('shows snackbar on error', (tester) async {
  when(() => mockAuthBloc.state).thenReturn(AuthInitial());

  whenListen(
    mockAuthBloc,
    Stream.fromIterable([AuthError('Network error')]),
    initialState: AuthInitial(),
  );

  await tester.pumpWidget(createWidget());
  await tester.pump(); // Process the stream

  expect(find.byType(SnackBar), findsOneWidget);
  expect(find.text('Network error'), findsOneWidget);
});
```

---

## Complete Test File Example

```dart
// test/presentation/bloc/todo_bloc_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTodoRepository extends Mock implements TodoRepository {}
class FakeTodo extends Fake implements Todo {}

void main() {
  late MockTodoRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeTodo());
  });

  setUp(() {
    mockRepository = MockTodoRepository();
  });

  group('TodoBloc', () {
    final testTodos = [
      Todo(id: '1', title: 'First'),
      Todo(id: '2', title: 'Second'),
    ];

    group('TodoLoadRequested', () {
      blocTest<TodoBloc, TodoState>(
        'emits [TodoLoading, TodoLoaded] on success',
        setUp: () {
          when(() => mockRepository.getTodos())
              .thenAnswer((_) async => testTodos);
        },
        build: () => TodoBloc(repository: mockRepository),
        act: (bloc) => bloc.add(TodoLoadRequested()),
        expect: () => [
          TodoLoading(),
          TodoLoaded(testTodos),
        ],
      );

      blocTest<TodoBloc, TodoState>(
        'emits [TodoLoading, TodoError] on failure',
        setUp: () {
          when(() => mockRepository.getTodos())
              .thenThrow(Exception('Failed'));
        },
        build: () => TodoBloc(repository: mockRepository),
        act: (bloc) => bloc.add(TodoLoadRequested()),
        expect: () => [
          TodoLoading(),
          isA<TodoError>(),
        ],
      );
    });

    group('TodoAdded', () {
      blocTest<TodoBloc, TodoState>(
        'adds todo and emits updated list',
        setUp: () {
          when(() => mockRepository.add(any())).thenAnswer((_) async {});
        },
        build: () => TodoBloc(repository: mockRepository),
        seed: () => TodoLoaded(testTodos),
        act: (bloc) => bloc.add(TodoAdded(Todo(id: '3', title: 'Third'))),
        expect: () => [
          isA<TodoLoaded>().having(
            (s) => s.todos.length,
            'todos length',
            equals(3),
          ),
        ],
      );
    });

    group('TodoDeleted', () {
      blocTest<TodoBloc, TodoState>(
        'removes todo and emits updated list',
        setUp: () {
          when(() => mockRepository.delete(any())).thenAnswer((_) async {});
        },
        build: () => TodoBloc(repository: mockRepository),
        seed: () => TodoLoaded(testTodos),
        act: (bloc) => bloc.add(TodoDeleted('1')),
        expect: () => [
          isA<TodoLoaded>().having(
            (s) => s.todos.length,
            'todos length',
            equals(1),
          ),
        ],
        verify: (_) {
          verify(() => mockRepository.delete('1')).called(1);
        },
      );
    });
  });
}
```
