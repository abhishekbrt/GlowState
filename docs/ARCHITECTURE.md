# GlowState Architecture

## Overview

GlowState uses a **feature-first clean architecture** with shared domain contracts that enable independent parallel development.

## Directory Structure

```
lib/
├── main.dart                      # App entry point
├── app.dart                       # MaterialApp + Router
│
├── config/                        # App configuration
│   ├── routes.dart               # GoRouter setup
│   └── environment.dart          # Dev/Staging/Prod config
│
├── core/                          # Shared utilities (non-domain)
│   ├── constants/                # App constants
│   ├── error/                    # Error types
│   ├── theme/                    # App theme
│   ├── utils/                    # Utilities
│   └── widgets/                  # Reusable widgets
│
├── shared/                        # Shared domain (CONTRACTS)
│   └── domain/
│       ├── entities/
│       │   ├── check_in.dart          # Check-in record
│       │   ├── daily_progress.dart    # Aggregated daily state
│       │   ├── photo_record.dart      # Single photo type
│       │   └── streak.dart            # Streak tracking
│       ├── enums/
│       │   └── check_in_type.dart     # Morning/Night enum
│       ├── events/
│       │   └── app_events.dart        # Event definitions
│       └── services/
│           ├── event_bus.dart         # Pub/sub system
│           └── event_bus_provider.dart
│
└── features/                      # Feature modules
    ├── auth/
    ├── camera/
    ├── check_in/
    ├── home/
    ├── notifications/
    ├── photo_gallery/
    ├── streak/
    └── timelapse/
```

## Feature Structure

Each feature follows this structure:

```
feature_name/
├── domain/                        # Business logic
│   ├── entities/                 # Feature-specific entities
│   ├── repositories/             # Repository interfaces
│   └── usecases/                 # Business orchestration
│
├── data/                          # Data layer
│   ├── datasources/              # Local/remote sources
│   ├── models/                   # Data models (JSON)
│   ├── repositories/             # Repository implementations
│   └── providers/                # Riverpod providers
│
└── presentation/                  # UI layer
    ├── screens/                  # Full pages
    ├── widgets/                  # Feature widgets
    └── providers/                # UI state providers
```

## Data Flow

```
┌─────────────────────────────────────────────────────────────────────────┐
│                           USER ACTIONS                                   │
└─────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                         PRESENTATION LAYER                               │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐  │
│  │  Camera  │  │  Gallery │  │ Check-In │  │  Streak  │  │ Timelapse│  │
│  │  Screen  │  │  Screen  │  │  Screen  │  │   Card   │  │  Screen  │  │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬─────┘  │
└───────┼─────────────┼─────────────┼─────────────┼─────────────┼────────┘
        │             │             │             │             │
        ▼             ▼             ▼             ▼             ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                          USE CASES LAYER                                 │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────────┐ │
│  │ Capture     │  │ Get Photos  │  │ Complete    │  │ Generate        │ │
│  │ Photo       │──▶│ UseCase     │  │ CheckIn     │──▶│ Timelapse       │ │
│  │ UseCase     │  │             │  │ UseCase     │  │ UseCase         │ │
│  └──────┬──────┘  └─────────────┘  └──────┬──────┘  └─────────────────┘ │
│         │                                  │                             │
│         │         ┌────────────────────────┘                             │
│         │         │                                                      │
│         ▼         ▼                                                      │
│  ┌─────────────────────┐     ┌─────────────────────┐                    │
│  │   EVENT BUS         │────▶│   Streak updates    │                    │
│  │ (CheckInCompleted)  │     │   automatically     │                    │
│  └─────────────────────┘     └─────────────────────┘                    │
└─────────────────────────────────────────────────────────────────────────┘
        │             │             │             │             │
        ▼             ▼             ▼             ▼             ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                      SHARED DOMAIN LAYER                                 │
│  ┌───────────────────────────────────────────────────────────────────┐  │
│  │                        PhotoRecord                                 │  │
│  │  {id, filePath, capturedAt, checkInType, isPrivate, cycleDay}     │  │
│  └───────────────────────────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────────────────────────┐  │
│  │                       DailyProgress                                │  │
│  │  {date, morningCheckIn, nightCheckIn, currentStreak, photos}       │  │
│  └───────────────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────────────┘
```

## Shared Entities (Contracts)

### CheckIn
Represents a completed check-in (morning or night). Used by:
- **Check-In**: Creates and manages check-ins
- **Home**: Displays today's check-in status
- **Streak**: Calculates consecutive day streaks
- **Events**: Passed in CheckInCompletedEvent

### Streak
Tracks user's consecutive check-in days. Used by:
- **Streak**: Manages streak calculations
- **Home**: Displays current streak
- **Events**: Passed in StreakUpdatedEvent
- **Notifications**: Streak-at-risk reminders

### PhotoRecord
Single source of truth for all photo data. Used by:
- **Camera**: Creates after capture
- **Photo Gallery**: Stores and retrieves
- **Timelapse**: Uses for video generation
- **Check-In**: Links to check-ins

### DailyProgress
Aggregated view of a day's progress. Used by:
- **Home Screen**: Today's status
- **Check-In**: Update progress
- **Streak**: Calculate streaks

### CheckInType
Enum for morning/night routines. Used by:
- **Camera**: Determine capture mode
- **Check-In**: Record type
- **Photo Gallery**: Filter photos
- **Notifications**: Schedule reminders

## Event System

Features communicate via events, not direct dependencies.

```dart
// Emitting an event
eventBus.emit(CheckInCompletedEvent(checkIn: checkIn));

// Listening to events
eventBus.on<CheckInCompletedEvent>().listen((event) {
  // React to check-in completion
});
```

### Available Events

| Event | Emitted By | Listened By |
|-------|------------|-------------|
| `PhotoCapturedEvent` | Camera | Gallery |
| `CheckInCompletedEvent` | Check-In | Streak, Home |
| `StreakUpdatedEvent` | Streak | Home, Notifications |
| `CycleCompletedEvent` | Check-In | Timelapse |
| `TimelapseGeneratedEvent` | Timelapse | Gallery |

## Use Cases

Use cases orchestrate multiple repositories:

| Use Case | Coordinates |
|----------|-------------|
| `CapturePhotoUseCase` | Camera → Gallery |
| `CompleteCheckInUseCase` | Check-In → Streak |
| `GenerateTimelapseUseCase` | Gallery → Timelapse |
| `GetDailyProgressUseCase` | Check-In + Gallery + Streak |

## Rules

### Domain Layer
- NO Flutter imports
- Pure Dart business logic only
- **Allowed annotations:** `freezed_annotation`, `json_annotation` (compile-time only, no runtime Flutter dependencies)

### Repository Interfaces
- Define in domain layer
- Implement in data layer
- Use shared entities

### Use Cases
- Coordinate multiple repositories
- Emit events for other features
- Handle business logic

### Providers
- Use `ref.watch()` in `build()`
- Use `ref.read()` in callbacks
- Never instantiate concrete classes in widgets

## Testing

- Use **Mocktail** (NOT Mockito)
- Follow TDD: RED → GREEN → REFACTOR
- Test use cases with mocked repositories
- Test repositories with mocked data sources
