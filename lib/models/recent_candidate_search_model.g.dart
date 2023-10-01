// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_candidate_search_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentCandidateSearchModelAdapter
    extends TypeAdapter<RecentCandidateSearchModel> {
  @override
  final int typeId = 2;

  @override
  RecentCandidateSearchModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentCandidateSearchModel(
      candidateName: fields[0] as String,
      city: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RecentCandidateSearchModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.candidateName)
      ..writeByte(1)
      ..write(obj.city);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentCandidateSearchModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
