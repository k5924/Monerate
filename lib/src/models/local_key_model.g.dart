// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_key_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalKeyModelAdapter extends TypeAdapter<LocalKeyModel> {
  @override
  final int typeId = 0;

  @override
  LocalKeyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalKeyModel()
      ..provider = fields[0] as String
      ..keyName = fields[1] as String
      ..value = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, LocalKeyModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.provider)
      ..writeByte(1)
      ..write(obj.keyName)
      ..writeByte(2)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalKeyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
