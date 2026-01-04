// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhotoModelAdapter extends TypeAdapter<PhotoModel> {
  @override
  final int typeId = 1;

  @override
  PhotoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhotoModel(
      id: fields[0] as String,
      filePath: fields[1] as String,
      capturedAt: fields[2] as DateTime,
      isMorning: fields[3] as bool,
      isPrivate: fields[4] as bool,
      thumbnailPath: fields[5] as String?,
      cycleDay: fields[6] as int?,
      notes: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PhotoModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.filePath)
      ..writeByte(2)
      ..write(obj.capturedAt)
      ..writeByte(3)
      ..write(obj.isMorning)
      ..writeByte(4)
      ..write(obj.isPrivate)
      ..writeByte(5)
      ..write(obj.thumbnailPath)
      ..writeByte(6)
      ..write(obj.cycleDay)
      ..writeByte(7)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
      notes: json['notes'] as String?,
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
      'notes': instance.notes,
    };
