import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glowstate/features/camera/domain/entities/captured_photo.dart';

part 'captured_photo_model.freezed.dart';
part 'captured_photo_model.g.dart';

@freezed
class CapturedPhotoModel with _$CapturedPhotoModel {
  const factory CapturedPhotoModel({
    required String id,
    required String filePath,
    required DateTime capturedAt,
    required bool isMorning,
    @Default(false) bool isPrivate,
    String? thumbnailPath,
  }) = _CapturedPhotoModel;

  factory CapturedPhotoModel.fromJson(Map<String, dynamic> json) =>
      _$CapturedPhotoModelFromJson(json);

  const CapturedPhotoModel._();

  CapturedPhoto toEntity() => CapturedPhoto(
    id: id,
    filePath: filePath,
    capturedAt: capturedAt,
    isMorning: isMorning,
    isPrivate: isPrivate,
    thumbnailPath: thumbnailPath,
  );

  static CapturedPhotoModel fromEntity(CapturedPhoto entity) =>
      CapturedPhotoModel(
        id: entity.id,
        filePath: entity.filePath,
        capturedAt: entity.capturedAt,
        isMorning: entity.isMorning,
        isPrivate: entity.isPrivate,
        thumbnailPath: entity.thumbnailPath,
      );
}
