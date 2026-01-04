import 'package:freezed_annotation/freezed_annotation.dart';

part 'captured_photo.freezed.dart';

@freezed
class CapturedPhoto with _$CapturedPhoto {
  const factory CapturedPhoto({
    required String id,
    required String filePath,
    required DateTime capturedAt,
    required bool isMorning,
    @Default(false) bool isPrivate,
    String? thumbnailPath,
  }) = _CapturedPhoto;
}
