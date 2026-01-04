import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:glowstate/features/photo_gallery/domain/entities/photo.dart';

part 'photo_model.freezed.dart';
part 'photo_model.g.dart';

@freezed
class PhotoModel with _$PhotoModel {
  const factory PhotoModel({
    required String id,
    required String filePath,
    required DateTime capturedAt,
    required bool isMorning,
    @Default(false) bool isPrivate,
    String? thumbnailPath,
    int? cycleDay,
  }) = _PhotoModel;

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);

  const PhotoModel._();

  Photo toEntity() => Photo(
    id: id,
    filePath: filePath,
    capturedAt: capturedAt,
    isMorning: isMorning,
    isPrivate: isPrivate,
    thumbnailPath: thumbnailPath,
    cycleDay: cycleDay,
  );

  static PhotoModel fromEntity(Photo entity) => PhotoModel(
    id: entity.id,
    filePath: entity.filePath,
    capturedAt: entity.capturedAt,
    isMorning: entity.isMorning,
    isPrivate: entity.isPrivate,
    thumbnailPath: entity.thumbnailPath,
    cycleDay: entity.cycleDay,
  );
}
