// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiaryModelAdapter extends TypeAdapter<DiaryModel> {
  @override
  final int typeId = 0;

  @override
  DiaryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiaryModel(
      imageUrls: (fields[5] as List?)?.cast<Uint8List>(),
      mode: fields[12] as String?,
      title: fields[2] as String,
      content: fields[3] as String,
      content2: fields[4] as String,
    )
      ..id = fields[1] as String
      ..year = fields[6] as int
      ..month = fields[7] as int
      ..day = fields[8] as int
      ..weekday = fields[9] as int
      ..createAt = fields[10] as DateTime
      ..updatedAt = fields[11] as DateTime;
  }

  @override
  void write(BinaryWriter writer, DiaryModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.content2)
      ..writeByte(5)
      ..write(obj.imageUrls)
      ..writeByte(6)
      ..write(obj.year)
      ..writeByte(7)
      ..write(obj.month)
      ..writeByte(8)
      ..write(obj.day)
      ..writeByte(9)
      ..write(obj.weekday)
      ..writeByte(10)
      ..write(obj.createAt)
      ..writeByte(11)
      ..write(obj.updatedAt)
      ..writeByte(12)
      ..write(obj.mode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiaryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
