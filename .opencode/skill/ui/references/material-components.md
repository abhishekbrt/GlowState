# Material 3 Components

## Scaffold Structure

```dart
Scaffold(
  appBar: AppBar(
    title: const Text('Screen Title'),
    leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
    actions: [
      IconButton(icon: const Icon(Icons.search), onPressed: () {}),
      IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
    ],
  ),
  body: const Center(child: Text('Content')),
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: const Icon(Icons.add),
  ),
  floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  bottomNavigationBar: NavigationBar(
    selectedIndex: currentIndex,
    onDestinationSelected: (index) => setState(() => currentIndex = index),
    destinations: const [
      NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
      NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
    ],
  ),
)
```

## Cards

```dart
Card(
  elevation: 2,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Card Title', style: theme.textTheme.titleLarge),
        const SizedBox(height: 8),
        Text('Card description goes here', style: theme.textTheme.bodyMedium),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(onPressed: () {}, child: const Text('Cancel')),
            const SizedBox(width: 8),
            FilledButton(onPressed: () {}, child: const Text('Confirm')),
          ],
        ),
      ],
    ),
  ),
)
```

## Buttons

```dart
// Primary action
FilledButton(onPressed: () {}, child: const Text('Submit'))

// Secondary action
FilledButton.tonal(onPressed: () {}, child: const Text('Save Draft'))

// Tertiary / low emphasis
OutlinedButton(onPressed: () {}, child: const Text('Cancel'))

// Text only
TextButton(onPressed: () {}, child: const Text('Learn more'))

// Icon button
IconButton(onPressed: () {}, icon: const Icon(Icons.favorite))

// FAB
FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add))
FloatingActionButton.extended(
  onPressed: () {},
  icon: const Icon(Icons.add),
  label: const Text('Create'),
)

// With icon
FilledButton.icon(
  onPressed: () {},
  icon: const Icon(Icons.send),
  label: const Text('Send'),
)
```

## Text Fields

```dart
TextField(
  controller: _controller,
  decoration: InputDecoration(
    labelText: 'Email',
    hintText: 'Enter your email',
    prefixIcon: const Icon(Icons.email),
    suffixIcon: IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () => _controller.clear(),
    ),
    border: const OutlineInputBorder(),
    errorText: hasError ? 'Invalid email' : null,
  ),
  keyboardType: TextInputType.emailAddress,
  textInputAction: TextInputAction.next,
  onChanged: (value) => validate(value),
  onSubmitted: (value) => submit(),
)
```

## Lists

```dart
// Standard list tile
ListTile(
  leading: const CircleAvatar(child: Icon(Icons.person)),
  title: const Text('John Doe'),
  subtitle: const Text('john@example.com'),
  trailing: const Icon(Icons.chevron_right),
  onTap: () {},
)

// Switch list tile
SwitchListTile(
  title: const Text('Notifications'),
  subtitle: const Text('Receive push notifications'),
  value: isEnabled,
  onChanged: (value) => setState(() => isEnabled = value),
)

// Checkbox list tile
CheckboxListTile(
  title: const Text('Accept terms'),
  value: isChecked,
  onChanged: (value) => setState(() => isChecked = value ?? false),
)
```

## Dialogs

```dart
// Alert dialog
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: const Text('Delete item?'),
    content: const Text('This action cannot be undone.'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      FilledButton(
        onPressed: () {
          deleteItem();
          Navigator.pop(context);
        },
        child: const Text('Delete'),
      ),
    ],
  ),
);

// Bottom sheet
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  builder: (context) => DraggableScrollableSheet(
    initialChildSize: 0.5,
    minChildSize: 0.25,
    maxChildSize: 0.9,
    expand: false,
    builder: (context, scrollController) => ListView(
      controller: scrollController,
      children: [...],
    ),
  ),
);
```

## Snackbar

```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: const Text('Item deleted'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () => undoDelete(),
    ),
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 4),
  ),
);
```

## Chips

```dart
// Input chip (user input like selected contacts)
InputChip(
  label: const Text('John'),
  avatar: const CircleAvatar(child: Text('J')),
  onDeleted: () {},
)

// Filter chip (filter options)
FilterChip(
  label: const Text('Vegetarian'),
  selected: isSelected,
  onSelected: (selected) => setState(() => isSelected = selected),
)

// Choice chip (single selection)
ChoiceChip(
  label: const Text('Small'),
  selected: size == 'small',
  onSelected: (selected) => setState(() => size = 'small'),
)

// Action chip (actions)
ActionChip(
  label: const Text('Share'),
  avatar: const Icon(Icons.share, size: 18),
  onPressed: () {},
)
```

## Theme Colors (Material 3)

```dart
// Access color scheme
final colors = Theme.of(context).colorScheme;

// Primary colors
colors.primary          // Main brand color
colors.onPrimary        // Text/icons on primary
colors.primaryContainer // Lighter primary for backgrounds

// Surface colors
colors.surface          // Card backgrounds
colors.onSurface        // Text on surface
colors.surfaceVariant   // Slightly different surface

// Error colors
colors.error            // Error states
colors.onError          // Text on error

// Others
colors.outline          // Borders
colors.outlineVariant   // Subtle borders
```
