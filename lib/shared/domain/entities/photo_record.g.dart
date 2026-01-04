// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PhotoRecordImpl _$$PhotoRecordImplFromJson(Map<String, dynamic> json) =>
    _$PhotoRecordImpl(
      id: json['id'] as String,
      filePath: json['filePath'] as String,
      capturedAt: DateTime.parse(json['capturedAt'] as String),
      checkInType: $enumDecode(_$CheckInTypeEnumMap, json['checkInType']),
      isPrivate: json['isPrivate'] as bool? ?? false,
      thumbnailPath: json['thumbnailPath'] as String?,
      cycleDay: (json['cycleDay'] as num?)?.toInt(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$PhotoRecordImplToJson(_$PhotoRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'filePath': instance.filePath,
      'capturedAt': instance.capturedAt.toIso8601String(),
      'checkInType': _$CheckInTypeEnumMap[instance.checkInType]!,
      'isPrivate': instance.isPrivate,
      'thumbnailPath': instance.thumbnailPath,
      'cycleDay': instance.cycleDay,
      'notes': instance.notes,
    };

const _$CheckInTypeEnumMap = {
  CheckInType.morning: 'morning',
  CheckInType.night: 'night',
};
