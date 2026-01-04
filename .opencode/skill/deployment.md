# Deployment

## Android

### Generate Keystore
```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA \
  -keysize 2048 -validity 10000 -alias upload
```

### Configure Signing

```properties
# android/key.properties
storePassword=<password>
keyPassword=<password>
keyAlias=upload
storeFile=/path/to/upload-keystore.jks
```

```groovy
// android/app/build.gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
        }
    }
}
```

### Build Commands
```bash
# APK (direct install)
flutter build apk --release

# Split by ABI (smaller)
flutter build apk --split-per-abi --release

# App Bundle (Play Store)
flutter build appbundle --release

# With obfuscation
flutter build appbundle --obfuscate --split-debug-info=build/symbols
```

## iOS

### Xcode Configuration
1. Open `ios/Runner.xcworkspace`
2. Select Runner → Signing & Capabilities
3. Set Team (Apple Developer account)
4. Set Bundle Identifier

### Build Commands
```bash
flutter build ios --release
flutter build ipa --release
flutter build ipa --obfuscate --split-debug-info=build/symbols
```

### Info.plist Requirements
```xml
<key>ITSAppUsesNonExemptEncryption</key>
<false/>
```

## Build Flavors

### Entry Points
```dart
// lib/main_dev.dart
void main() {
  AppConfig.init(Environment.dev);
  runApp(const MyApp());
}

// lib/main_prod.dart
void main() {
  AppConfig.init(Environment.prod);
  runApp(const MyApp());
}
```

### Build with Flavor
```bash
# Android
flutter build apk --flavor dev -t lib/main_dev.dart
flutter build appbundle --flavor prod -t lib/main_prod.dart

# iOS
flutter build ipa --flavor prod -t lib/main_prod.dart
```

## CI/CD (GitHub Actions)

```yaml
name: Build
on:
  push:
    branches: [main]

jobs:
  build-android:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'
      - run: flutter pub get
      - run: flutter test
      - run: flutter build apk --release
      - uses: actions/upload-artifact@v4
        with:
          name: release-apk
          path: build/app/outputs/flutter-apk/app-release.apk

  build-ios:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'
      - run: flutter pub get
      - run: flutter build ios --release --no-codesign
```

## Version Management

```yaml
# pubspec.yaml
# version: MAJOR.MINOR.PATCH+BUILD
version: 1.2.3+45
# 1.2.3 = versionName (user visible)
# 45 = versionCode (must increment)
```

## Code Obfuscation

```bash
flutter build apk --obfuscate --split-debug-info=build/symbols

# Symbolicate crash reports
flutter symbolize -i crash_log.txt -d build/symbols
```

## Checklist

### Android
- [ ] Keystore generated and secured
- [ ] Version code incremented
- [ ] App icons in all densities
- [ ] ProGuard rules if needed

### iOS
- [ ] Team and bundle ID configured
- [ ] Privacy descriptions in Info.plist
- [ ] App icons (1024x1024)
- [ ] Export compliance answered
