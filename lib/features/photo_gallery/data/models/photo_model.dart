import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:glowstate/shared/domain/entities/photo_record.dart';
import 'package:glowstate/shared/domain/enums/check_in_type.dart';

part 'photo_model.freezed.dart';
part 'photo_model.g.dart';

@freezed
@HiveType(typeId: 1)
class PhotoModel with _$PhotoModel {
  const PhotoModel._();

  const factory PhotoModel({
    @HiveField(0) required String id,
    @HiveField(1) required String filePath,
    @HiveField(2) required DateTime capturedAt,
    @HiveField(3) required bool isMorning,
    @HiveField(4) @Default(false) bool isPrivate,
    @HiveField(5) String? thumbnailPath,
    @HiveField(6) int? cycleDay,
    @HiveField(7) String? notes,
  }) = _PhotoModel;

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);

  /// Convert FROM shared PhotoRecord TO local PhotoModel
  factory PhotoModel.fromPhotoRecord(PhotoRecord record) => PhotoModel(
    id: record.id,
    filePath: record.filePath,
    capturedAt: record.capturedAt,
    isMorning: record.checkInType == CheckInType.morning,
    isPrivate: record.isPrivate,
    thumbnailPath: record.thumbnailPath,
    cycleDay: record.cycleDay,
    notes: record.notes,
  );

  /// Convert TO shared PhotoRecord FROM local PhotoModel
  PhotoRecord toPhotoRecord() => PhotoRecord(
    id: id,
    filePath: filePath,
    capturedAt: capturedAt,
    checkInType: isMorning ? CheckInType.morning : CheckInType.night,
    isPrivate: isPrivate,
    thumbnailPath: thumbnailPath,
    cycleDay: cycleDay,
    notes: notes,
  );
}
