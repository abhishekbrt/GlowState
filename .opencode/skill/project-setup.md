# Project Setup

## Create New Project

```bash
# Standard project
flutter create --org com.yourcompany --project-name my_app ./my_app

# With specific platforms
flutter create --platforms=android,ios --org com.yourcompany my_app

# Add platform to existing project
flutter create --platforms=web .
```

## pubspec.yaml

```yaml
name: my_app
description: A Flutter application.
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: ^3.0.0

dependencies:
  flutter:
    sdk: flutter
    
  # State Management + DI (Riverpod)
  flutter_riverpod: ^3.1.0
  riverpod_annotation: ^3.0.3
  
  # Networking
  dio: ^5.4.0
  
  # Local Storage
  shared_preferences: ^2.2.0
  
  # Navigation
  go_router: ^13.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  mocktail: ^1.0.0
  riverpod_generator: ^3.0.3
  build_runner: ^2.4.0

flutter:
  uses-material-design: true
  
  assets:
    - assets/images/
    - assets/icons/
```

## Feature-First Structure

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── providers/             # Core Riverpod providers
│   ├── network/api_client.dart
│   ├── error/failures.dart
│   ├── theme/app_theme.dart
│   └── widgets/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── home/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── config/
    ├── routes.dart
    └── environment.dart
```

## Main Entry Point

```dart
// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}
```

## App Configuration

```dart
// app.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'My App',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: router,
    );
  }
}
```

## Environment Configuration

```dart
// config/environment.dart
enum Environment { dev, staging, prod }

class AppConfig {
  static late Environment environment;
  static late String apiBaseUrl;

  static void init(Environment env) {
    environment = env;
    apiBaseUrl = switch (env) {
      Environment.dev => 'https://dev-api.example.com',
      Environment.staging => 'https://staging-api.example.com',
      Environment.prod => 'https://api.example.com',
    };
  }
}

// main_dev.dart
void main() {
  AppConfig.init(Environment.dev);
  runApp(const MyApp());
}
```

Run with: `flutter run -t lib/main_dev.dart`

## Android Configuration

### android/app/build.gradle
```groovy
android {
    namespace "com.yourcompany.myapp"
    compileSdkVersion 34
    
    defaultConfig {
        applicationId "com.yourcompany.myapp"
        minSdkVersion 21
        targetSdkVersion 34
    }
}
```

### AndroidManifest.xml Permissions
```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

## iOS Configuration

### ios/Runner/Info.plist
```xml
<key>NSCameraUsageDescription</key>
<string>Camera access for photos</string>

<key>NSLocationWhenInUseUsageDescription</key>
<string>Location for nearby features</string>
```

### ios/Podfile
```ruby
platform :ios, '12.0'
```

## Useful Commands

```bash
flutter pub get              # Install dependencies
flutter pub upgrade          # Upgrade to latest compatible
flutter pub outdated         # Check outdated packages
flutter clean && flutter pub get  # Reset project
dart run build_runner build --delete-conflicting-outputs  # Code generation
```
