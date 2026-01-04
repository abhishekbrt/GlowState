# Layouts

## Row and Column

### Main Axis vs Cross Axis

```dart
// Column: main = vertical, cross = horizontal
Column(
  mainAxisAlignment: MainAxisAlignment.center,      // Vertical alignment
  crossAxisAlignment: CrossAxisAlignment.start,    // Horizontal alignment
  mainAxisSize: MainAxisSize.min,                  // Shrink to content
  children: [...],
)

// Row: main = horizontal, cross = vertical
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Horizontal
  crossAxisAlignment: CrossAxisAlignment.center,      // Vertical
  children: [...],
)
```

### MainAxisAlignment Options

| Value | Effect |
|-------|--------|
| `start` | Pack at start |
| `end` | Pack at end |
| `center` | Center all |
| `spaceBetween` | Even space between, none at edges |
| `spaceAround` | Even space around each child |
| `spaceEvenly` | Even space including edges |

### Expanded and Flexible

```dart
Row(
  children: [
    // Fixed width
    const SizedBox(width: 50, child: Icon(Icons.menu)),
    
    // Takes 2/3 of remaining space
    Expanded(
      flex: 2,
      child: Text('Title'),
    ),
    
    // Takes 1/3 of remaining space
    Expanded(
      flex: 1,
      child: Text('Subtitle'),
    ),
  ],
)
```

### Avoid Overflow

```dart
// ❌ Text can overflow
Row(children: [Text(veryLongText)])

// ✅ Wrap in Expanded
Row(children: [Expanded(child: Text(veryLongText))])

// ✅ Or use Flexible with overflow handling
Row(children: [
  Flexible(
    child: Text(veryLongText, overflow: TextOverflow.ellipsis),
  ),
])
```

## Stack

### Basic Positioning

```dart
Stack(
  children: [
    // Base layer (defines size if no other constraints)
    Container(width: 200, height: 200, color: Colors.blue),
    
    // Absolute positioning
    Positioned(
      top: 10,
      left: 10,
      child: Text('Top Left'),
    ),
    
    // Fill entire stack
    Positioned.fill(
      child: Center(child: Text('Centered')),
    ),
    
    // Partial positioning (other sides unconstrained)
    Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: BottomBar(),
    ),
  ],
)
```

### Stack Alignment

```dart
Stack(
  alignment: Alignment.center,  // Default position for non-Positioned children
  clipBehavior: Clip.none,      // Allow overflow
  children: [
    Container(width: 100, height: 100, color: Colors.red),
    Container(width: 50, height: 50, color: Colors.blue),  // Centered on red
  ],
)
```

## ListView

### Builder Pattern (Use for 20+ items)

```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ListTile(
    key: ValueKey(items[index].id),
    title: Text(items[index].name),
  ),
)
```

### Separated

```dart
ListView.separated(
  itemCount: items.length,
  separatorBuilder: (context, index) => const Divider(),
  itemBuilder: (context, index) => ListTile(title: Text(items[index])),
)
```

### Performance Tips

```dart
ListView.builder(
  itemCount: items.length,
  itemExtent: 72,           // Fixed height = faster layout
  cacheExtent: 500,         // Pre-render offscreen items
  itemBuilder: (context, index) => RepaintBoundary(
    child: ExpensiveWidget(items[index]),
  ),
)
```

## GridView

```dart
GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 8,
    crossAxisSpacing: 8,
    childAspectRatio: 1.0,  // width / height
  ),
  itemCount: items.length,
  itemBuilder: (context, index) => Card(child: ...),
)

// Adaptive column count
GridView.builder(
  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 200,  // Max item width
    mainAxisSpacing: 8,
    crossAxisSpacing: 8,
  ),
  ...
)
```

## Wrap

For flow layout (like tags):

```dart
Wrap(
  spacing: 8,           // Horizontal gap
  runSpacing: 8,        // Vertical gap between lines
  children: tags.map((tag) => Chip(label: Text(tag))).toList(),
)
```

## Container vs Other Widgets

| Need | Use |
|------|-----|
| Spacing only | `SizedBox` |
| Padding only | `Padding` |
| Alignment only | `Align` or `Center` |
| Decoration (color, border, shadow) | `Container` |
| Multiple of above | `Container` |

```dart
// ✅ Minimal - just padding
Padding(
  padding: const EdgeInsets.all(16),
  child: Text('Hello'),
)

// ✅ Container when you need decoration
Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  ),
  child: Text('Hello'),
)
```
