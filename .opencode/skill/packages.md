# Packages

## Adding Dependencies

```yaml
# pubspec.yaml
dependencies:
  http: ^1.1.0           # Exact minor version
  flutter_riverpod: ">=3.1.0"    # Minimum version
  dio: ^5.0.0            # Compatible with 5.x.x
```

```bash
flutter pub get              # Install
flutter pub upgrade          # Upgrade
flutter pub outdated         # Check outdated
flutter pub add http         # Add package
flutter pub add --dev mocktail  # Add dev dependency
```

## Essential Packages

### State Management
```yaml
flutter_riverpod: ^3.1.0      # Primary - reactive state + DI
riverpod_annotation: ^3.0.3   # Code generation annotations

# Alternative for complex event flows
flutter_bloc: ^8.1.0          # Event-driven state
equatable: ^2.0.0             # Value equality for states
```

### Code Generation
```yaml
dev_dependencies:
  build_runner: ^2.4.0        # Code gen runner
  riverpod_generator: ^3.0.3  # Riverpod provider generation
  json_serializable: ^6.7.0   # JSON serialization
  freezed: ^2.4.0             # Immutable classes (optional)
```

### Networking
```yaml
dio: ^5.4.0                # HTTP with interceptors
http: ^1.1.0               # Simple HTTP
retrofit: ^4.0.0           # Type-safe API client
```

### Local Storage
```yaml
shared_preferences: ^2.2.0 # Key-value
sqflite: ^2.3.0            # SQLite
hive: ^2.2.0               # Fast NoSQL
flutter_secure_storage: ^9.0.0  # Encrypted storage
```

### Navigation
```yaml
go_router: ^13.0.0         # Declarative routing
```

### UI
```yaml
cached_network_image: ^3.3.0
flutter_svg: ^2.0.0
shimmer: ^3.0.0
```

### Utilities
```yaml
intl: ^0.18.0              # Internationalization
url_launcher: ^6.2.0       # Open URLs
share_plus: ^7.0.0         # Share content
permission_handler: ^11.0.0
```

### Testing
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  mocktail: ^1.0.0         # Mocking (no codegen)
  bloc_test: ^9.1.0        # BLoC testing (if using BLoC)
```

## Code Generation Commands

```bash
# One-time build
dart run build_runner build --delete-conflicting-outputs

# Watch mode (during development)
dart run build_runner watch --delete-conflicting-outputs

# Clean generated files
dart run build_runner clean
```

## Creating a Package

```bash
flutter create --template=package my_package
```

### Structure
```
my_package/
├── lib/
│   ├── my_package.dart     # Main export
│   └── src/
├── test/
├── example/
├── pubspec.yaml
├── README.md
└── CHANGELOG.md
```

### Export API
```dart
// lib/my_package.dart
library my_package;

export 'src/models/user.dart';
export 'src/widgets/custom_button.dart';
export 'src/utils/helpers.dart' show formatDate;
```

## Creating a Plugin

```bash
flutter create --org com.yourcompany --template=plugin \
  --platforms=android,ios my_plugin
```

```yaml
# pubspec.yaml
flutter:
  plugin:
    platforms:
      android:
        package: com.yourcompany.my_plugin
        pluginClass: MyPlugin
      ios:
        pluginClass: MyPluginPlugin
```

## Dependency Overrides

```yaml
# Force specific version
dependency_overrides:
  http: 1.0.0

# Local development
dependency_overrides:
  my_package:
    path: ../my_package

# Git dependency
dependencies:
  my_package:
    git:
      url: https://github.com/user/my_package.git
      ref: main
```

## Publishing

```bash
# Pre-publish checks
flutter analyze
dart format --set-exit-if-changed .
flutter test
flutter pub publish --dry-run

# Publish
flutter pub publish
```

## Monorepo (Melos)

```yaml
# melos.yaml
name: my_workspace
packages:
  - packages/**

scripts:
  analyze:
    run: melos exec -- flutter analyze
  test:
    run: melos exec -- flutter test
```

```bash
melos bootstrap     # Link packages
melos run analyze   # Run across all
melos run test
```
