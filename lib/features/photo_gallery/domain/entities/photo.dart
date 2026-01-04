import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo.freezed.dart';

@freezed
class Photo with _$Photo {
  const factory Photo({
    required String id,
    required String filePath,
    required DateTime capturedAt,
    required bool isMorning,
    @Default(false) bool isPrivate,
    String? thumbnailPath,
    int? cycleDay,
  }) = _Photo;
}
