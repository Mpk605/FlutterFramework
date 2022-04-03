// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ex3.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JobOfferAdapter extends TypeAdapter<JobOffer> {
  @override
  final int typeId = 2;

  @override
  JobOffer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JobOffer(
      companyName: fields[0] as String,
      salary: fields[1] as int,
      status: fields[2] as int,
      details: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, JobOffer obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.companyName)
      ..writeByte(1)
      ..write(obj.salary)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.details);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobOfferAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
