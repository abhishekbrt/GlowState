# Navigation

## go_router (Recommended)

### Setup

```yaml
dependencies:
  go_router: ^13.0.0
```

### Router Configuration

```dart
// config/routes.dart
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'details/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return DetailScreen(id: id);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
  redirect: (context, state) {
    final isLoggedIn = context.read<AuthBloc>().state is AuthAuthenticated;
    final isLoggingIn = state.matchedLocation == '/login';

    if (!isLoggedIn && !isLoggingIn) return '/login';
    if (isLoggedIn && isLoggingIn) return '/';
    return null;
  },
  errorBuilder: (context, state) => ErrorScreen(error: state.error),
);
```

### Using Router

```dart
// In MaterialApp
MaterialApp.router(routerConfig: router)

// Navigation
context.go('/details/123');           // Replace current route
context.push('/details/123');         // Push onto stack
context.pop();                        // Go back
context.pushReplacement('/home');     // Replace and push

// With query parameters
context.go('/search?q=flutter&page=1');
final query = state.uri.queryParameters['q'];

// Named routes
GoRoute(
  name: 'detail',
  path: 'details/:id',
  builder: (context, state) => DetailScreen(id: state.pathParameters['id']!),
)
context.goNamed('detail', pathParameters: {'id': '123'});
```

### Shell Routes (Bottom Navigation)

```dart
ShellRoute(
  builder: (context, state, child) => ScaffoldWithNavBar(child: child),
  routes: [
    GoRoute(path: '/home', builder: (context, state) => const HomeTab()),
    GoRoute(path: '/search', builder: (context, state) => const SearchTab()),
    GoRoute(path: '/profile', builder: (context, state) => const ProfileTab()),
  ],
)

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;
  const ScaffoldWithNavBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateIndex(context),
        onDestinationSelected: (i) => _onTap(i, context),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  int _calculateIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/search')) return 1;
    if (location.startsWith('/profile')) return 2;
    return 0;
  }

  void _onTap(int index, BuildContext context) {
    switch (index) {
      case 0: context.go('/home');
      case 1: context.go('/search');
      case 2: context.go('/profile');
    }
  }
}
```

## Deep Linking

### Android (android/app/src/main/AndroidManifest.xml)
```xml
<intent-filter android:autoVerify="true">
  <action android:name="android.intent.action.VIEW"/>
  <category android:name="android.intent.category.DEFAULT"/>
  <category android:name="android.intent.category.BROWSABLE"/>
  <data android:scheme="https" android:host="example.com"/>
</intent-filter>
<intent-filter>
  <action android:name="android.intent.action.VIEW"/>
  <category android:name="android.intent.category.DEFAULT"/>
  <category android:name="android.intent.category.BROWSABLE"/>
  <data android:scheme="myapp"/>
</intent-filter>
```

### iOS (ios/Runner/Info.plist)
```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleTypeRole</key><string>Editor</string>
    <key>CFBundleURLSchemes</key>
    <array><string>myapp</string></array>
  </dict>
</array>
<key>FlutterDeepLinkingEnabled</key>
<true/>
```

## Page Transitions

```dart
GoRoute(
  path: '/details',
  pageBuilder: (context, state) => CustomTransitionPage(
    key: state.pageKey,
    child: const DetailScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  ),
)

// Slide transition
transitionsBuilder: (context, animation, secondaryAnimation, child) {
  final tween = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
      .chain(CurveTween(curve: Curves.easeInOut));
  return SlideTransition(position: animation.drive(tween), child: child);
}
```

## Dialogs and Bottom Sheets

```dart
// Bottom sheet
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  builder: (context) => const FilterSheet(),
);

// Dialog
final confirmed = await showDialog<bool>(
  context: context,
  builder: (context) => AlertDialog(
    title: const Text('Confirm'),
    content: const Text('Are you sure?'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context, false),
        child: const Text('Cancel'),
      ),
      FilledButton(
        onPressed: () => Navigator.pop(context, true),
        child: const Text('Confirm'),
      ),
    ],
  ),
);
```
