import 'dart:async';

import '../events/app_events.dart';

/// Simple event bus for feature-to-feature communication
///
/// This enables loose coupling between features.
/// Features don't need to know about each other,
/// they just emit and listen to events.
///
/// Example:
/// ```dart
/// // Emit an event
/// eventBus.emit(CheckInCompletedEvent(checkIn: checkIn));
///
/// // Listen to events
/// eventBus.on<CheckInCompletedEvent>().listen((event) {
///   // React to check-in completion
/// });
/// ```
class EventBus {
  EventBus._();

  static final EventBus _instance = EventBus._();

  /// Singleton instance
  static EventBus get instance => _instance;

  /// Factory constructor returns singleton
  factory EventBus() => _instance;

  final _controller = StreamController<AppEvent>.broadcast();

  /// Stream of all events
  Stream<AppEvent> get stream => _controller.stream;

  /// Emit an event to all listeners
  void emit(AppEvent event) {
    if (!_controller.isClosed) {
      _controller.add(event);
    }
  }

  /// Listen to events of a specific type
  ///
  /// Example:
  /// ```dart
  /// eventBus.on<CheckInCompletedEvent>().listen((event) {
  ///   print('Check-in completed: ${event.checkIn.type}');
  /// });
  /// ```
  Stream<T> on<T extends AppEvent>() {
    return stream.where((event) => event is T).cast<T>();
  }

  /// Listen to all events
  StreamSubscription<AppEvent> onAny(void Function(AppEvent event) handler) {
    return stream.listen(handler);
  }

  /// Dispose the event bus (call on app termination)
  void dispose() {
    _controller.close();
  }
}

/// Extension to make listening easier with automatic disposal
extension EventBusExtensions on EventBus {
  /// Listen to an event type and automatically dispose when done
  void listenTo<T extends AppEvent>(
    void Function(T event) handler, {
    Function? onError,
    void Function()? onDone,
  }) {
    on<T>().listen(handler, onError: onError, onDone: onDone);
  }
}
