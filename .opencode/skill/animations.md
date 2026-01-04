# Animations

## Choosing Animation Type

| Type | Use When |
|------|----------|
| Implicit | Simple property changes (size, color, position) |
| Explicit | Complex sequences, custom curves, interruptible |
| Hero | Shared element between screens |

## Implicit Animations

### AnimatedContainer

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  width: _expanded ? 200 : 100,
  height: _expanded ? 200 : 100,
  decoration: BoxDecoration(
    color: _expanded ? Colors.blue : Colors.red,
    borderRadius: BorderRadius.circular(_expanded ? 16 : 8),
  ),
  child: const Center(child: Text('Tap me')),
)
```

### Common Implicit Widgets

```dart
// Fade
AnimatedOpacity(
  duration: const Duration(milliseconds: 300),
  opacity: _visible ? 1.0 : 0.0,
  child: widget,
)

// Scale
AnimatedScale(
  duration: const Duration(milliseconds: 300),
  scale: _enlarged ? 1.5 : 1.0,
  child: widget,
)

// Rotation
AnimatedRotation(
  duration: const Duration(milliseconds: 300),
  turns: _rotated ? 0.5 : 0,
  child: widget,
)

// Cross fade between widgets
AnimatedCrossFade(
  duration: const Duration(milliseconds: 300),
  crossFadeState: _showFirst 
      ? CrossFadeState.showFirst 
      : CrossFadeState.showSecond,
  firstChild: const Icon(Icons.play_arrow),
  secondChild: const Icon(Icons.pause),
)

// Animated switcher (for changing children)
AnimatedSwitcher(
  duration: const Duration(milliseconds: 300),
  child: Text('$_count', key: ValueKey<int>(_count)),
)
```

## Explicit Animations

### AnimationController

```dart
class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _animation = Tween<double>(begin: 0, end: 300).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: _animation.value,
          height: _animation.value,
          child: child,
        );
      },
      child: const FlutterLogo(),
    );
  }
}
```

### Controls

```dart
_controller.forward();           // Play forward
_controller.reverse();           // Play backward
_controller.repeat();            // Loop forever
_controller.repeat(reverse: true);  // Ping-pong
_controller.stop();              // Stop
_controller.reset();             // Reset to beginning
```

### Tween Types

```dart
Tween<double>(begin: 0, end: 100)
ColorTween(begin: Colors.red, end: Colors.blue)
Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
BorderRadiusTween(begin: BorderRadius.zero, end: BorderRadius.circular(20))
```

## Hero Animations

```dart
// Source screen
Hero(
  tag: 'product-${product.id}',
  child: Image.network(product.imageUrl),
)

// Destination screen (same tag)
Hero(
  tag: 'product-${product.id}',
  child: Image.network(product.imageUrl),
)
```

## Animated List

```dart
final _listKey = GlobalKey<AnimatedListState>();
final List<String> _items = [];

void _addItem() {
  final index = _items.length;
  _items.add('Item $index');
  _listKey.currentState?.insertItem(index);
}

void _removeItem(int index) {
  final removed = _items.removeAt(index);
  _listKey.currentState?.removeItem(
    index,
    (context, animation) => SizeTransition(
      sizeFactor: animation,
      child: ListTile(title: Text(removed)),
    ),
  );
}

AnimatedList(
  key: _listKey,
  initialItemCount: _items.length,
  itemBuilder: (context, index, animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: ListTile(title: Text(_items[index])),
    );
  },
)
```

## Performance Tips

- Use `const` for non-animated children
- Set `child` parameter in AnimatedBuilder for static parts
- Prefer implicit animations for simple cases
- Always dispose controllers in `dispose()`
- Use `RepaintBoundary` to isolate expensive animations
