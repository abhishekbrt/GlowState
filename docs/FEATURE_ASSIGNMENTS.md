# Feature Assignments for Junior Developers

## How to Work Independently

Each feature is isolated. You implement the **inside** of your feature while the **contracts** (interfaces) ensure everything connects.

## Your Workflow

1. **Read your feature's repository interface** - This is your contract
2. **Implement the data sources** - Local storage (Hive)
3. **Implement the repository** - Replace `throw UnimplementedError()` with real logic
4. **Write tests** - TDD: test first, then implement
5. **Use shared entities** - PhotoRecord, CheckInType from shared domain

## Feature Assignments

### Feature: Camera (Junior A)

**Files to implement:**
- `lib/features/camera/data/datasources/camera_local_source.dart`
- `lib/features/camera/data/repositories/camera_repository_impl.dart`
- `lib/features/camera/domain/services/face_alignment_service.dart`

**Contract:** `lib/features/camera/domain/repositories/camera_repository.dart`

**Your responsibility:**
- Initialize camera hardware
- Capture photos (return file path)
- Switch cameras, control flash/zoom
- Implement ghost overlay alignment

**You receive:**
- `CheckInType` (morning/night) from shared domain

**You provide:**
- File path of captured image (used by CapturePhotoUseCase)

**DO NOT:**
- Save photos to gallery (CapturePhotoUseCase handles this)
- Create PhotoRecord (CapturePhotoUseCase handles this)

---

### Feature: Photo Gallery (Junior B)

**Files to implement:**
- `lib/features/photo_gallery/data/datasources/photo_local_source.dart`
- `lib/features/photo_gallery/data/repositories/photo_repository_impl.dart`
- `lib/features/photo_gallery/presentation/screens/gallery_screen.dart`

**Contract:** `lib/features/photo_gallery/domain/repositories/photo_repository.dart`

**Your responsibility:**
- Store PhotoRecord to Hive
- Retrieve photos by date/range
- Generate thumbnails
- Filter photos for timelapse

**You receive:**
- `PhotoRecord` from shared domain (created by CapturePhotoUseCase)

**You provide:**
- Stored photos for Timelapse feature
- Latest photo for Camera ghost overlay

**DO NOT:**
- Capture photos (Camera feature does this)
- Generate timelapse (Timelapse feature does this)

---

### Feature: Check-In (Junior C)

**Files to implement:**
- `lib/features/check_in/data/datasources/check_in_local_source.dart`
- `lib/features/check_in/data/repositories/check_in_repository_impl.dart`
- `lib/features/check_in/presentation/screens/check_in_screen.dart`

**Contract:** `lib/features/check_in/domain/repositories/check_in_repository.dart`

**Your responsibility:**
- Store check-in records to Hive
- Track morning/night completion
- Calculate points
- Query check-in history

**You receive:**
- `CheckInType` from shared domain
- Optional `photoId` linking to PhotoRecord

**You provide:**
- Check-in data for Streak calculation
- Today's status for Home screen

**DO NOT:**
- Update streak (CompleteCheckInUseCase handles this)
- Capture photos (Camera feature does this)

---

### Feature: Streak (Junior D)

**Files to implement:**
- `lib/features/streak/data/datasources/streak_local_source.dart`
- `lib/features/streak/data/repositories/streak_repository_impl.dart`
- `lib/features/streak/presentation/widgets/streak_card.dart`

**Contract:** `lib/features/streak/domain/repositories/streak_repository.dart`

**Your responsibility:**
- Persist streak data to Hive
- Calculate current streak
- Track longest streak
- Validate streak on app launch

**You receive:**
- Called by CompleteCheckInUseCase when check-in completes

**You provide:**
- Current streak count for Home screen
- Streak status for notifications

**DO NOT:**
- Listen directly to check-in changes (UseCase handles this)

---

### Feature: Timelapse (Junior E)

**Files to implement:**
- `lib/features/timelapse/data/datasources/video_generator_source.dart`
- `lib/features/timelapse/data/repositories/timelapse_repository_impl.dart`
- `lib/features/timelapse/presentation/screens/timelapse_screen.dart`

**Contract:** `lib/features/timelapse/domain/repositories/timelapse_repository.dart`

**Your responsibility:**
- Generate video from photos using FFmpeg
- Report generation progress
- Store generated videos
- Check FFmpeg availability

**You receive:**
- `List<PhotoRecord>` from GenerateTimelapseUseCase

**You provide:**
- Generated timelapse video path

**DO NOT:**
- Fetch photos directly (UseCase fetches from PhotoRepository)

---

### Feature: Notifications (Junior F)

**Files to implement:**
- `lib/features/notifications/data/datasources/notification_local_source.dart`
- `lib/features/notifications/data/repositories/notification_repository_impl.dart`
- Platform notification service implementation

**Contract:** `lib/features/notifications/domain/repositories/notification_repository.dart`

**Your responsibility:**
- Store notification settings
- Schedule local notifications
- Handle notification permissions
- Listen to streak events for reminders

**You receive:**
- Settings from user preferences
- Events from EventBus

**You provide:**
- Scheduled reminders for check-ins

---

## Shared Code (DO NOT MODIFY)

These files are shared contracts. **Do not modify without team discussion:**

```
lib/shared/domain/
├── entities/
│   ├── photo_record.dart        # READ ONLY
│   └── daily_progress.dart      # READ ONLY
├── enums/
│   └── check_in_type.dart       # READ ONLY
├── events/
│   └── app_events.dart          # READ ONLY
└── services/
    └── event_bus.dart           # READ ONLY
```

## Git Rules

1. **Stay in your feature folder**
2. **DO NOT modify shared domain** without approval
3. **Commit often** with clear messages
4. **No force push** to main
5. **Run analyze before PR**: `flutter analyze --fatal-infos`

## Before Submitting PR

- [ ] All `UnimplementedError()` replaced with real logic
- [ ] Tests written and passing
- [ ] `flutter analyze` clean
- [ ] `dart format .` applied
- [ ] Only your feature files modified

## Questions?

If you need to modify a shared contract, **ask first**. We'll discuss as a team to avoid breaking other features.
