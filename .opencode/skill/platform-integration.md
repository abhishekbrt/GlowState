# Platform Integration

## Platform Channels

### MethodChannel (Request-Response)

```dart
// Dart side
class BatteryInfo {
  static const _channel = MethodChannel('com.example.app/battery');

  static Future<int> getBatteryLevel() async {
    try {
      final level = await _channel.invokeMethod<int>('getBatteryLevel');
      return level ?? -1;
    } on PlatformException catch (e) {
      throw Exception('Failed: ${e.message}');
    }
  }
}
```

### Android (Kotlin)
```kotlin
class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.app/battery"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getBatteryLevel" -> {
                        val level = getBatteryLevel()
                        if (level != -1) result.success(level)
                        else result.error("UNAVAILABLE", "Not available", null)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun getBatteryLevel(): Int {
        val manager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        return manager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }
}
```

### iOS (Swift)
```swift
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(
            name: "com.example.app/battery",
            binaryMessenger: controller.binaryMessenger
        )
        
        channel.setMethodCallHandler { [weak self] call, result in
            if call.method == "getBatteryLevel" {
                result(self?.getBatteryLevel() ?? -1)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func getBatteryLevel() -> Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return Int(UIDevice.current.batteryLevel * 100)
    }
}
```

## EventChannel (Streams)

```dart
class SensorStream {
  static const _channel = EventChannel('com.example.app/sensor');
  
  static Stream<double> get stream {
    return _channel.receiveBroadcastStream().map((e) => e as double);
  }
}

// Usage
SensorStream.stream.listen((value) => print('Value: $value'));
```

## Platform Checks

```dart
import 'dart:io';
import 'package:flutter/foundation.dart';

if (Platform.isAndroid) { /* Android code */ }
if (Platform.isIOS) { /* iOS code */ }
if (kIsWeb) { /* Web code */ }

// Theme-based
final platform = Theme.of(context).platform;
if (platform == TargetPlatform.iOS) {
  return CupertinoButton(onPressed: () {}, child: text);
}
return ElevatedButton(onPressed: () {}, child: text);
```

## Permissions

### Android (AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

### iOS (Info.plist)
```xml
<key>NSCameraUsageDescription</key>
<string>Camera for taking photos</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>Location for nearby places</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Photo library for selecting images</string>
```

### Runtime Permissions
```dart
// package: permission_handler
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestCamera() async {
  final status = await Permission.camera.request();
  
  if (status.isGranted) return true;
  if (status.isPermanentlyDenied) {
    await openAppSettings();
  }
  return false;
}

// Multiple permissions
final statuses = await [
  Permission.camera,
  Permission.microphone,
].request();
```

## Plugin Development

```bash
flutter create --org com.example --template=plugin \
  --platforms=android,ios my_plugin
```

### Structure
```
my_plugin/
├── lib/
│   └── my_plugin.dart
├── android/src/main/kotlin/.../MyPlugin.kt
├── ios/Classes/MyPlugin.swift
└── example/
```

## Deep Links

### Handle in Router
```dart
GoRouter(
  routes: [
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        return ProductScreen(id: state.pathParameters['id']!);
      },
    ),
  ],
)
```
