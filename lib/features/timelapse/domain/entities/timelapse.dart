import 'package:freezed_annotation/freezed_annotation.dart';

part 'timelapse.freezed.dart';

@freezed
class Timelapse with _$Timelapse {
  const factory Timelapse({
    required String id,
    required String videoPath,
    required DateTime createdAt,
    required DateTime startDate,
    required DateTime endDate,
    required int photoCount,
    required int durationSeconds,
    String? thumbnailPath,
  }) = _Timelapse;
}
