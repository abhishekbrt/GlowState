import 'package:glowstate/features/camera/domain/repositories/camera_repository.dart';
import 'package:glowstate/features/photo_gallery/domain/repositories/photo_repository.dart';
import 'package:glowstate/shared/domain/entities/photo_record.dart';
import 'package:glowstate/shared/domain/enums/check_in_type.dart';
import 'package:glowstate/shared/domain/events/app_events.dart';
import 'package:glowstate/shared/domain/services/event_bus.dart';
import 'package:uuid/uuid.dart';

/// Use case for capturing a photo and saving it to the gallery
///
/// This orchestrates:
/// 1. Camera capture (returns file path)
/// 2. PhotoRecord creation (with metadata)
/// 3. Gallery storage
/// 4. Event emission (for other features to react)
///
/// Juniors implement [CameraRepository] and [PhotoRepository] separately.
/// This use case ensures they work together correctly.
class CapturePhotoUseCase {
  CapturePhotoUseCase({
    required CameraRepository cameraRepository,
    required PhotoRepository photoRepository,
    required EventBus eventBus,
    int? currentCycleDay,
  }) : _cameraRepository = cameraRepository,
       _photoRepository = photoRepository,
       _eventBus = eventBus,
       _currentCycleDay = currentCycleDay;

  final CameraRepository _cameraRepository;
  final PhotoRepository _photoRepository;
  final EventBus _eventBus;
  final int? _currentCycleDay;

  static const _uuid = Uuid();

  /// Captures a photo and saves it to the gallery
  ///
  /// [checkInType] - Morning or night routine
  /// Returns the saved [PhotoRecord]
  Future<PhotoRecord> execute({required CheckInType checkInType}) async {
    // 1. Capture photo via camera (returns file path)
    final filePath = await _cameraRepository.capturePhoto(
      checkInType: checkInType,
    );

    // 2. Create PhotoRecord with metadata
    final photo = PhotoRecord(
      id: _uuid.v4(),
      filePath: filePath,
      capturedAt: DateTime.now(),
      checkInType: checkInType,
      cycleDay: _currentCycleDay,
    );

    // 3. Save to gallery
    final savedPhoto = await _photoRepository.savePhoto(photo);

    // 4. Emit event for other features to react
    _eventBus.emit(PhotoCapturedEvent(photo: savedPhoto));

    return savedPhoto;
  }
}
