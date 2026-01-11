import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:glowstate/shared/domain/services/event_bus.dart';

/// Provider for the global event bus
///
/// This is a singleton that enables feature-to-feature communication.
/// Features emit events when something happens, other features listen.
final eventBusProvider = Provider<EventBus>((ref) {
  return EventBus.instance;
});
