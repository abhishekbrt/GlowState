// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'captured_photo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CapturedPhotoModelImpl _$$CapturedPhotoModelImplFromJson(
  Map<String, dynamic> json,
) => _$CapturedPhotoModelImpl(
  id: json['id'] as String,
  filePath: json['filePath'] as String,
  capturedAt: DateTime.parse(json['capturedAt'] as String),
  isMorning: json['isMorning'] as bool,
  isPrivate: json['isPrivate'] as bool? ?? false,
  thumbnailPath: json['thumbnailPath'] as String?,
);

Map<String, dynamic> _$$CapturedPhotoModelImplToJson(
  _$CapturedPhotoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'filePath': instance.filePath,
  'capturedAt': instance.capturedAt.toIso8601String(),
  'isMorning': instance.isMorning,
  'isPrivate': instance.isPrivate,
  'thumbnailPath': instance.thumbnailPath,
};
