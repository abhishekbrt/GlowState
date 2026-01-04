# Performance

## Key Metrics

| Metric | Target | Tool |
|--------|--------|------|
| Frame Rate | 60fps (16ms/frame) | DevTools Performance |
| Startup Time | < 2s cold start | `flutter run --trace-startup` |
| App Size | < 10MB | `flutter build --analyze-size` |

## Widget Optimization

### Use const

```dart
// ✅ Cached, never rebuilds
const SizedBox(height: 16)
const Text('Static text')

// ❌ Recreated every build
SizedBox(height: 16)
```

### Extract Static Widgets

```dart
// ❌ ExpensiveWidget rebuilds on every _count change
Column(
  children: [
    Text('Count: $_count'),
    ExpensiveWidget(),
  ],
)

// ✅ ExpensiveWidget only builds once
Column(
  children: [
    Text('Count: $_count'),
    const ExpensiveWidget(),
  ],
)
```

### Granular Rebuilds

```dart
// ❌ Rebuilds on any cart change
final cart = context.watch<Cart>();
return Text('Items: ${cart.itemCount}');

// ✅ Only rebuilds when itemCount changes
final count = context.select<Cart, int>((c) => c.itemCount);
return Text('Items: $count');
```

## List Performance

### ListView.builder

```dart
// ✅ Items built lazily
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ItemWidget(items[index]),
)

// ❌ All items built upfront
ListView(children: items.map((i) => ItemWidget(i)).toList())
```

### Fixed Item Extent

```dart
ListView.builder(
  itemCount: items.length,
  itemExtent: 80,      // Fixed height = faster layout
  cacheExtent: 500,    // Pre-render beyond viewport
  itemBuilder: (context, index) => ItemWidget(items[index]),
)
```

### RepaintBoundary for Complex Items

```dart
ListView.builder(
  itemBuilder: (context, index) {
    return RepaintBoundary(
      child: ComplexItemWidget(items[index]),
    );
  },
)
```

## Image Optimization

```dart
// Resize images for display size
Image.asset(
  'assets/large_image.jpg',
  cacheWidth: 300,
  cacheHeight: 300,
)

// Cached network images
CachedNetworkImage(
  imageUrl: url,
  placeholder: (context, url) => const CircularProgressIndicator(),
  memCacheWidth: 300,
)
```

## Isolates for Heavy Work

```dart
// Move compute-heavy operations off main thread
Future<List<Item>> parseItems(String json) async {
  return await Isolate.run(() {
    final data = jsonDecode(json) as List;
    return data.map((e) => Item.fromJson(e)).toList();
  });
}
```

## Build Mode

```bash
# Debug (slow, for development)
flutter run

# Profile (for performance testing)
flutter run --profile

# Release (optimized)
flutter run --release
flutter build apk --release
```

## App Size

```bash
# Analyze size
flutter build apk --analyze-size

# Split by ABI (smaller APKs)
flutter build apk --split-per-abi

# Check unused dependencies
flutter pub deps --style=compact
```

## DevTools

```bash
# Run with profiling enabled
flutter run --profile

# Access DevTools (link shown in terminal)
# Or: flutter pub global run devtools
```

### What to Look For
- Janky frames (> 16ms)
- Expensive build phases
- Memory leaks (growing heap)
- Unnecessary rebuilds

## Checklist

- [ ] Use `const` constructors
- [ ] Use `ListView.builder` for lists > 20 items
- [ ] Cache network images
- [ ] Resize images for display size
- [ ] Use isolates for heavy computation
- [ ] Profile in release/profile mode
- [ ] Dispose controllers and subscriptions
