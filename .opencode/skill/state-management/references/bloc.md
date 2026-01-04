# BLoC Pattern

## Dependencies

```yaml
dependencies:
  flutter_bloc: ^8.1.0
  equatable: ^2.0.0

dev_dependencies:
  bloc_test: ^9.1.0
```

## Complete Feature Example

### Events

```dart
// features/auth/presentation/bloc/auth_event.dart
sealed class AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  
  AuthLoginRequested({required this.email, required this.password});
}

class AuthLogoutRequested extends AuthEvent {}

class AuthCheckRequested extends AuthEvent {}
```

### States

```dart
// features/auth/presentation/bloc/auth_state.dart
sealed class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  
  const AuthAuthenticated(this.user);
  
  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  
  const AuthError(this.message);
  
  @override
  List<Object?> get props => [message];
}
```

### BLoC

```dart
// features/auth/presentation/bloc/auth_bloc.dart
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthCheckRequested>(_onCheckRequested);
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    final result = await _authRepository.login(event.email, event.password);
    
    switch (result) {
      case Success(:final data):
        emit(AuthAuthenticated(data));
      case Failure(:final failure):
        emit(AuthError(failure.message));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.logout();
    emit(AuthUnauthenticated());
  }

  Future<void> _onCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final user = await _authRepository.getCurrentUser();
    if (user != null) {
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
```

## Providing BLoC

### Screen Level (Recommended)

```dart
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: const LoginView(),
    );
  }
}
```

### App Level (For Global State)

```dart
void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBloc>()..add(AuthCheckRequested())),
        BlocProvider(create: (_) => sl<ThemeBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}
```

## Consuming State

### BlocBuilder (UI)

```dart
BlocBuilder<AuthBloc, AuthState>(
  builder: (context, state) {
    return switch (state) {
      AuthInitial() || AuthLoading() => const CircularProgressIndicator(),
      AuthAuthenticated(:final user) => Text('Hello, ${user.name}'),
      AuthUnauthenticated() => const LoginForm(),
      AuthError(:final message) => Text('Error: $message'),
    };
  },
)
```

### BlocSelector (Granular Rebuild)

```dart
// Only rebuilds when user name changes
BlocSelector<AuthBloc, AuthState, String?>(
  selector: (state) {
    if (state is AuthAuthenticated) return state.user.name;
    return null;
  },
  builder: (context, userName) {
    return Text(userName ?? 'Guest');
  },
)
```

### BlocListener (Side Effects)

```dart
BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is AuthError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
    if (state is AuthAuthenticated) {
      context.go('/home');
    }
  },
  child: const LoginForm(),
)
```

### BlocConsumer (Both)

```dart
BlocConsumer<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is AuthAuthenticated) {
      context.go('/home');
    }
  },
  builder: (context, state) {
    if (state is AuthLoading) {
      return const CircularProgressIndicator();
    }
    return const LoginForm();
  },
)
```

## Dispatching Events

```dart
// Read context (won't rebuild on state change)
context.read<AuthBloc>().add(
  AuthLoginRequested(email: email, password: password),
);

// From callback
onPressed: () {
  context.read<AuthBloc>().add(AuthLogoutRequested());
}
```

## Testing BLoC

```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthBloc bloc;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    bloc = AuthBloc(authRepository: mockRepository);
  });

  tearDown(() => bloc.close());

  group('AuthLoginRequested', () {
    final testUser = User(id: '1', name: 'Test', email: 'test@test.com');

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthAuthenticated] on success',
      build: () {
        when(() => mockRepository.login(any(), any()))
            .thenAnswer((_) async => Success(testUser));
        return bloc;
      },
      act: (bloc) => bloc.add(
        AuthLoginRequested(email: 'test@test.com', password: 'pass'),
      ),
      expect: () => [
        AuthLoading(),
        AuthAuthenticated(testUser),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] on failure',
      build: () {
        when(() => mockRepository.login(any(), any()))
            .thenAnswer((_) async => const Failure(AuthFailure('Invalid')));
        return bloc;
      },
      act: (bloc) => bloc.add(
        AuthLoginRequested(email: 'test@test.com', password: 'wrong'),
      ),
      expect: () => [
        AuthLoading(),
        const AuthError('Invalid'),
      ],
    );
  });
}
```

## Cubit (Simpler Alternative)

Use Cubit when you don't need event classes:

```dart
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    
    final result = await _authRepository.login(email, password);
    
    switch (result) {
      case Success(:final data):
        emit(AuthAuthenticated(data));
      case Failure(:final failure):
        emit(AuthError(failure.message));
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    emit(AuthUnauthenticated());
  }
}

// Usage
context.read<AuthCubit>().login(email, password);
```
