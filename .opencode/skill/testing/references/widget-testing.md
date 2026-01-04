# Widget Testing

Widget tests verify UI components render correctly and respond to interactions.

## Setup

```yaml
# pubspec.yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mocktail: ^1.0.0
```

---

## Test Helpers

Create reusable helpers to reduce boilerplate:

```dart
// test/helpers/test_helpers.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Wraps widget with MaterialApp for testing
Widget pumpApp(Widget child) {
  return MaterialApp(
    home: child,
  );
}

/// Wraps widget with MaterialApp and theme
Widget pumpAppWithTheme(Widget child, {ThemeData? theme}) {
  return MaterialApp(
    theme: theme ?? ThemeData.light(),
    home: child,
  );
}

/// Wraps widget with a ChangeNotifier provider
Widget pumpAppWithProvider<T extends ChangeNotifier>(
  Widget child, {
  required T value,
}) {
  return MaterialApp(
    home: ChangeNotifierProvider<T>.value(
      value: value,
      child: child,
    ),
  );
}

/// Wraps widget with multiple providers
Widget pumpAppWithProviders(
  Widget child, {
  required List<SingleChildWidget> providers,
}) {
  return MaterialApp(
    home: MultiProvider(
      providers: providers,
      child: child,
    ),
  );
}

/// Wraps widget with Scaffold for proper Material context
Widget pumpScaffold(Widget child) {
  return MaterialApp(
    home: Scaffold(body: child),
  );
}
```

---

## Basic Widget Test

```dart
// test/presentation/widgets/counter_widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/presentation/widgets/counter_widget.dart';

void main() {
  testWidgets('Counter starts at 0 and increments on tap', (tester) async {
    // Arrange - Build widget
    await tester.pumpWidget(
      const MaterialApp(home: CounterWidget()),
    );

    // Assert - Initial state
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Act - Tap increment button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump(); // Rebuild widget

    // Assert - New state
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Counter decrements on minus button tap', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: CounterWidget(initialValue: 5)),
    );

    expect(find.text('5'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();

    expect(find.text('4'), findsOneWidget);
  });
}
```

---

## Widget Finders

### By Text
```dart
find.text('Hello');
find.text('Submit');
find.textContaining('Error');  // Partial match
```

### By Type
```dart
find.byType(ElevatedButton);
find.byType(TextField);
find.byType(CircularProgressIndicator);
```

### By Icon
```dart
find.byIcon(Icons.add);
find.byIcon(Icons.favorite);
```

### By Key
```dart
find.byKey(const Key('submit-button'));
find.byKey(const ValueKey('user-123'));
```

### By Widget Predicate
```dart
find.byWidgetPredicate(
  (widget) => widget is Text && widget.data!.contains('Error'),
);

find.byWidgetPredicate(
  (widget) => widget is Container && widget.color == Colors.red,
);
```

### Descendant / Ancestor
```dart
// Find text inside a specific Card
find.descendant(
  of: find.byType(Card),
  matching: find.text('Title'),
);

// Find Card containing specific text
find.ancestor(
  of: find.text('Hello'),
  matching: find.byType(Card),
);
```

### Multiple Results
```dart
find.byType(ListTile).first;
find.byType(ListTile).last;
find.byType(ListTile).at(2);  // Third item (0-indexed)
```

---

## Widget Interactions

### Tapping
```dart
// Simple tap
await tester.tap(find.byType(ElevatedButton));
await tester.pump();

// Tap and wait for animations
await tester.tap(find.text('Submit'));
await tester.pumpAndSettle();

// Tap at specific position
await tester.tapAt(const Offset(100, 200));
await tester.pump();
```

### Text Entry
```dart
// Enter text
await tester.enterText(find.byType(TextField), 'Hello World');
await tester.pump();

// Clear text field
await tester.enterText(find.byType(TextField), '');
await tester.pump();

// Enter text in specific field
await tester.enterText(
  find.byKey(const Key('email-field')),
  'test@example.com',
);
```

### Scrolling
```dart
// Scroll down
await tester.drag(find.byType(ListView), const Offset(0, -300));
await tester.pumpAndSettle();

// Scroll up
await tester.drag(find.byType(ListView), const Offset(0, 300));
await tester.pumpAndSettle();

// Scroll until visible
await tester.scrollUntilVisible(
  find.text('Item 50'),
  300,  // delta per scroll
  scrollable: find.byType(Scrollable),
);
```

### Gestures
```dart
// Long press
await tester.longPress(find.text('Item'));
await tester.pump();

// Double tap
await tester.tap(find.text('Item'));
await tester.pump(const Duration(milliseconds: 100));
await tester.tap(find.text('Item'));
await tester.pump();

// Swipe to dismiss
await tester.drag(find.text('Delete me'), const Offset(-500, 0));
await tester.pumpAndSettle();

// Fling (fast scroll)
await tester.fling(find.byType(ListView), const Offset(0, -500), 1000);
await tester.pumpAndSettle();
```

---

## Testing with Providers

```dart
// test/presentation/screens/todo_list_screen_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockTodoViewModel extends Mock implements TodoViewModel {}

void main() {
  late MockTodoViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockTodoViewModel();
    // Setup default stubs
    when(() => mockViewModel.todos).thenReturn([]);
    when(() => mockViewModel.isLoading).thenReturn(false);
    when(() => mockViewModel.errorMessage).thenReturn(null);
  });

  Widget createWidget() {
    return MaterialApp(
      home: ChangeNotifierProvider<TodoViewModel>.value(
        value: mockViewModel,
        child: const TodoListScreen(),
      ),
    );
  }

  testWidgets('shows loading indicator when isLoading is true', (tester) async {
    when(() => mockViewModel.isLoading).thenReturn(true);

    await tester.pumpWidget(createWidget());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(ListView), findsNothing);
  });

  testWidgets('shows todos when loaded', (tester) async {
    when(() => mockViewModel.todos).thenReturn([
      Todo(id: '1', title: 'Buy groceries'),
      Todo(id: '2', title: 'Walk the dog'),
    ]);

    await tester.pumpWidget(createWidget());

    expect(find.text('Buy groceries'), findsOneWidget);
    expect(find.text('Walk the dog'), findsOneWidget);
  });

  testWidgets('shows error message when errorMessage is set', (tester) async {
    when(() => mockViewModel.errorMessage).thenReturn('Failed to load todos');

    await tester.pumpWidget(createWidget());

    expect(find.text('Failed to load todos'), findsOneWidget);
  });

  testWidgets('calls loadTodos on init', (tester) async {
    when(() => mockViewModel.loadTodos()).thenAnswer((_) async {});

    await tester.pumpWidget(createWidget());

    verify(() => mockViewModel.loadTodos()).called(1);
  });

  testWidgets('calls toggleTodo when checkbox tapped', (tester) async {
    when(() => mockViewModel.todos).thenReturn([
      Todo(id: '1', title: 'Test Todo', completed: false),
    ]);
    when(() => mockViewModel.toggleTodo(any())).thenAnswer((_) async {});

    await tester.pumpWidget(createWidget());

    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    verify(() => mockViewModel.toggleTodo('1')).called(1);
  });
}
```

---

## Testing Navigation

```dart
testWidgets('navigates to detail screen on tap', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: const TodoListScreen(),
      routes: {
        '/detail': (context) => const TodoDetailScreen(),
      },
    ),
  );

  await tester.tap(find.text('Todo Item'));
  await tester.pumpAndSettle();

  expect(find.byType(TodoDetailScreen), findsOneWidget);
  expect(find.byType(TodoListScreen), findsNothing);
});

testWidgets('navigates back on back button', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: const DetailScreen(),
    ),
  );

  // Tap back button in AppBar
  await tester.tap(find.byType(BackButton));
  await tester.pumpAndSettle();

  // Or use Navigator
  final NavigatorState navigator = tester.state(find.byType(Navigator));
  navigator.pop();
  await tester.pumpAndSettle();
});
```

---

## Testing Dialogs and Bottom Sheets

```dart
testWidgets('shows confirmation dialog on delete', (tester) async {
  await tester.pumpWidget(
    MaterialApp(home: const TodoListScreen()),
  );

  // Trigger delete action
  await tester.tap(find.byIcon(Icons.delete).first);
  await tester.pumpAndSettle();

  // Verify dialog appears
  expect(find.text('Are you sure?'), findsOneWidget);
  expect(find.text('Cancel'), findsOneWidget);
  expect(find.text('Delete'), findsOneWidget);

  // Tap cancel
  await tester.tap(find.text('Cancel'));
  await tester.pumpAndSettle();

  // Dialog dismissed
  expect(find.text('Are you sure?'), findsNothing);
});

testWidgets('shows bottom sheet on FAB tap', (tester) async {
  await tester.pumpWidget(
    MaterialApp(home: const HomeScreen()),
  );

  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle();

  expect(find.byType(BottomSheet), findsOneWidget);
  expect(find.text('Add New Item'), findsOneWidget);
});
```

---

## Testing Forms

```dart
testWidgets('form validation shows errors', (tester) async {
  await tester.pumpWidget(
    MaterialApp(home: const LoginScreen()),
  );

  // Submit empty form
  await tester.tap(find.text('Login'));
  await tester.pump();

  // Check error messages
  expect(find.text('Email is required'), findsOneWidget);
  expect(find.text('Password is required'), findsOneWidget);
});

testWidgets('form submits with valid data', (tester) async {
  final mockAuth = MockAuthService();
  when(() => mockAuth.login(any(), any()))
      .thenAnswer((_) async => User(id: '1'));

  await tester.pumpWidget(
    MaterialApp(
      home: Provider<AuthService>.value(
        value: mockAuth,
        child: const LoginScreen(),
      ),
    ),
  );

  // Enter valid data
  await tester.enterText(
    find.byKey(const Key('email-field')),
    'test@example.com',
  );
  await tester.enterText(
    find.byKey(const Key('password-field')),
    'password123',
  );

  // Submit
  await tester.tap(find.text('Login'));
  await tester.pumpAndSettle();

  // Verify login called
  verify(() => mockAuth.login('test@example.com', 'password123')).called(1);
});
```

---

## Testing Snackbars

```dart
testWidgets('shows snackbar on save', (tester) async {
  await tester.pumpWidget(
    MaterialApp(home: const EditScreen()),
  );

  await tester.tap(find.text('Save'));
  await tester.pump(); // Show snackbar

  expect(find.text('Saved successfully'), findsOneWidget);
  expect(find.byType(SnackBar), findsOneWidget);

  // Wait for snackbar to disappear
  await tester.pump(const Duration(seconds: 4));
  expect(find.byType(SnackBar), findsNothing);
});
```

---

## pump vs pumpAndSettle

| Method | Use When |
|--------|----------|
| `pump()` | Single frame rebuild needed |
| `pump(Duration)` | Need to advance time |
| `pumpAndSettle()` | Wait for all animations to complete |

```dart
// pump() - Single rebuild
await tester.tap(find.byType(Button));
await tester.pump(); // Rebuild once

// pump(Duration) - Advance time
await tester.pump(const Duration(milliseconds: 500));

// pumpAndSettle() - Wait for animations
await tester.tap(find.byType(Button));
await tester.pumpAndSettle(); // Wait until no more frames
```

**Warning:** `pumpAndSettle()` will timeout if animations never complete (e.g., infinite animations). Use `pump()` with duration instead.

---

## Testing Responsive Layouts

```dart
testWidgets('shows drawer on mobile', (tester) async {
  // Set mobile screen size
  tester.view.physicalSize = const Size(400, 800);
  tester.view.devicePixelRatio = 1.0;

  await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

  expect(find.byType(Drawer), findsNothing);
  expect(find.byIcon(Icons.menu), findsOneWidget);

  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
});

testWidgets('shows sidebar on tablet', (tester) async {
  // Set tablet screen size
  tester.view.physicalSize = const Size(1024, 768);
  tester.view.devicePixelRatio = 1.0;

  await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

  expect(find.byType(NavigationRail), findsOneWidget);
  expect(find.byIcon(Icons.menu), findsNothing);

  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });
});
```

---

## Common Assertions

```dart
// Widget exists
expect(find.text('Hello'), findsOneWidget);
expect(find.byType(Button), findsWidgets);  // One or more
expect(find.text('Missing'), findsNothing);
expect(find.byType(Card), findsNWidgets(3));  // Exactly 3
expect(find.byType(ListTile), findsAtLeast(5));

// Widget properties
final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
expect(button.enabled, isTrue);

final text = tester.widget<Text>(find.text('Hello'));
expect(text.style?.color, equals(Colors.red));
```
