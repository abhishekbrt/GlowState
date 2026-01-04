# Responsive Design

## LayoutBuilder

React to parent constraints:

```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 900) {
      return DesktopLayout();
    } else if (constraints.maxWidth > 600) {
      return TabletLayout();
    } else {
      return MobileLayout();
    }
  },
)
```

## MediaQuery

Access device information:

```dart
final size = MediaQuery.of(context).size;
final width = size.width;
final height = size.height;
final padding = MediaQuery.of(context).padding;  // Safe area insets
final orientation = MediaQuery.of(context).orientation;
final textScale = MediaQuery.of(context).textScaleFactor;

// Device type detection
bool isTablet = width > 600;
bool isDesktop = width > 900;
```

## Breakpoint Constants

```dart
// core/utils/breakpoints.dart
abstract class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
}

// Usage
class ResponsiveBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= Breakpoints.desktop && desktop != null) {
          return desktop!;
        }
        if (constraints.maxWidth >= Breakpoints.mobile && tablet != null) {
          return tablet!;
        }
        return mobile;
      },
    );
  }
}
```

## Adaptive Widgets

### Platform-Specific Widgets

```dart
Widget buildAdaptiveButton(BuildContext context) {
  final platform = Theme.of(context).platform;
  
  if (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS) {
    return CupertinoButton.filled(
      onPressed: () {},
      child: const Text('Submit'),
    );
  }
  
  return FilledButton(
    onPressed: () {},
    child: const Text('Submit'),
  );
}
```

### Adaptive Dialog

```dart
Future<bool?> showAdaptiveConfirmDialog(BuildContext context) {
  final platform = Theme.of(context).platform;
  
  if (platform == TargetPlatform.iOS) {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Confirm'),
        content: const Text('Are you sure?'),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  
  return showDialog<bool>(
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
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
```

## Responsive Grid

```dart
// Columns adjust based on width
GridView.builder(
  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 300,  // Max item width
    mainAxisSpacing: 16,
    crossAxisSpacing: 16,
    childAspectRatio: 1.5,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) => ItemCard(items[index]),
)
```

## Flexible Padding

```dart
// Padding that scales with screen size
EdgeInsets responsivePadding(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  
  if (width > 900) {
    return const EdgeInsets.symmetric(horizontal: 64, vertical: 32);
  } else if (width > 600) {
    return const EdgeInsets.symmetric(horizontal: 32, vertical: 24);
  }
  return const EdgeInsets.all(16);
}

// Usage
Padding(
  padding: responsivePadding(context),
  child: Content(),
)
```

## Orientation Handling

```dart
OrientationBuilder(
  builder: (context, orientation) {
    if (orientation == Orientation.landscape) {
      return Row(
        children: [
          Expanded(child: ImageSection()),
          Expanded(child: ContentSection()),
        ],
      );
    }
    return Column(
      children: [
        ImageSection(),
        ContentSection(),
      ],
    );
  },
)
```

## Responsive Text

```dart
// Scale text based on screen width
double responsiveFontSize(BuildContext context, double baseSize) {
  final width = MediaQuery.of(context).size.width;
  final scale = (width / 375).clamp(0.8, 1.2);  // 375 = baseline width
  return baseSize * scale;
}

// Usage
Text(
  'Heading',
  style: TextStyle(fontSize: responsiveFontSize(context, 24)),
)
```

## Avoid Hardcoded Dimensions

```dart
// ❌ Fixed width breaks on small screens
Container(width: 400, child: Form())

// ✅ Constrained but flexible
ConstrainedBox(
  constraints: const BoxConstraints(maxWidth: 400),
  child: Form(),
)

// ✅ Percentage of screen
SizedBox(
  width: MediaQuery.of(context).size.width * 0.8,
  child: Form(),
)
```
