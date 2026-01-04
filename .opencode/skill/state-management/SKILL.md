---
name: flutter-state-management
description: State management patterns for Flutter with Riverpod as primary solution. Covers provider types, async state, and local state patterns. Use when managing app state or implementing feature state logic.
---

# Flutter State Management

## Quick Decision

| Scenario | Use |
|----------|-----|
| Form input, toggle, animation trigger | `setState` |
| Single shared value (simple) | `ValueNotifier` or `StateProvider` |
| Feature with loading/error/success | `AsyncNotifierProvider` (Riverpod) |
| Mutable state with business logic | `NotifierProvider` (Riverpod) |
| Complex event flows, event tracking | `BLoC` (alternative) |

## Detailed Guides

| Topic | Guide | Use When |
|-------|-------|----------|
| Riverpod | [riverpod.md](references/riverpod.md) | Primary - most features, DI, async state |
| BLoC Pattern | [bloc.md](references/bloc.md) | Alternative - complex event-driven flows |

## Riverpod Quick Start

### Setup

```dart
// main.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}
```

### Provider with Code Generation

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
}
```

### Consuming in Widget

```dart
class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

## Local State

### setState (Widget-Local)

```dart
class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _count = 0;

  void _increment() {
    setState(() => _count++);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: $_count'),
        ElevatedButton(onPressed: _increment, child: const Text('Add')),
      ],
    );
  }
}
```

### ValueNotifier (Shared Single Value)

```dart
// Create notifier
final counterNotifier = ValueNotifier<int>(0);

// Listen in widget
ValueListenableBuilder<int>(
  valueListenable: counterNotifier,
  builder: (context, value, child) {
    return Text('Count: $value');
  },
)

// Update
counterNotifier.value++;

// Dispose when done
counterNotifier.dispose();
```

## Async State Pattern

### AsyncNotifier for Feature State

```dart
@riverpod
class UserProfile extends _$UserProfile {
  @override
  FutureOr<User?> build() async {
    final repo = ref.watch(userRepositoryProvider);
    return repo.getCurrentUser();
  }

  Future<void> updateName(String name) async {
    final current = state.valueOrNull;
    if (current == null) return;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(userRepositoryProvider);
      return repo.updateUser(current.copyWith(name: name));
    });
  }
}
```

### Consuming AsyncValue

```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  final userAsync = ref.watch(userProfileProvider);

  return userAsync.when(
    data: (user) => user != null 
        ? ProfileView(user: user)
        : const LoginPrompt(),
    loading: () => const ProfileSkeleton(),
    error: (error, _) => ErrorView(
      message: error.toString(),
      onRetry: () => ref.invalidate(userProfileProvider),
    ),
  );
}
```

## ref.watch vs ref.read

| Method | Rebuilds | Use In |
|--------|----------|--------|
| `ref.watch()` | Yes | `build()` method |
| `ref.read()` | No | Callbacks, event handlers |
| `ref.listen()` | No (triggers callback) | Side effects |

```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  // Side effects (snackbar, navigation)
  ref.listen(authProvider, (prev, next) {
    if (next is AsyncError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(next.error.toString())),
      );
    }
  });

  // Reactive rebuild
  final auth = ref.watch(authProvider);
  
  return ElevatedButton(
    // Non-reactive callback
    onPressed: () => ref.read(authProvider.notifier).logout(),
    child: const Text('Logout'),
  );
}
```

## When to Use BLoC

Use BLoC (see [bloc.md](references/bloc.md)) when you need:

| Scenario | Why BLoC |
|----------|----------|
| Event logging/analytics | Events create audit trail |
| Complex event transformations | `on<Event>` handlers with debounce, throttle |
| Undo/redo functionality | Event replay capability |
| Strict separation of concerns | Events as explicit API |

For most features, Riverpod's `NotifierProvider` or `AsyncNotifierProvider` is simpler and sufficient.

## Provider Types Summary

| Type | Use Case | Example |
|------|----------|---------|
| `@riverpod` function | Computed/derived values | `themeModeProvider` |
| `NotifierProvider` | Mutable sync state | `counterProvider` |
| `AsyncNotifierProvider` | Mutable async state | `authProvider` |
| `FutureProvider` | Read-only async data | `productsProvider` |
| `StreamProvider` | Real-time data | `messagesProvider` |
| Family (parameterized) | Per-ID data | `userProvider(userId: '123')` |

## Anti-Patterns

| Avoid | Instead |
|-------|---------|
| Business logic in widgets | Move to Notifier classes |
| `ref.read` in `build()` | Use `ref.watch` for reactive updates |
| Manual loading/error booleans | Use `AsyncValue` from `AsyncNotifierProvider` |
| Global mutable state | Use scoped providers with Riverpod |
| `setState` after async without `mounted` check | Use Riverpod (handles lifecycle) |
| Nested ProviderScope (usually) | Single root scope, use overrides for testing |
