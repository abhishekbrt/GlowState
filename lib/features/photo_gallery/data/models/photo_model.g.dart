// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PhotoModelImpl _$$PhotoModelImplFromJson(Map<String, dynamic> json) =>
    _$PhotoModelImpl(
      id: json['id'] as String,
      filePath: json['filePath'] as String,
      capturedAt: DateTime.parse(json['capturedAt'] as String),
      isMorning: json['isMorning'] as bool,
      isPrivate: json['isPrivate'] as bool? ?? false,
      thumbnailPath: json['thumbnailPath'] as String?,
      cycleDay: (json['cycleDay'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$PhotoModelImplToJson(_$PhotoModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'filePath': instance.filePath,
      'capturedAt': instance.capturedAt.toIso8601String(),
      'isMorning': instance.isMorning,
      'isPrivate': instance.isPrivate,
      'thumbnailPath': instance.thumbnailPath,
      'cycleDay': instance.cycleDay,
    };
