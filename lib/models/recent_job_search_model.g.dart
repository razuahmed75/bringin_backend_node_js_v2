// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_job_search_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentJobSearchModelAdapter extends TypeAdapter<RecentJobSearchModel> {
  @override
  final int typeId = 1;

  @override
  RecentJobSearchModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentJobSearchModel(
      jobTitle: fields[0] as String,
      city: fields[1] as String,
      division: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RecentJobSearchModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.jobTitle)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.division);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentJobSearchModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
