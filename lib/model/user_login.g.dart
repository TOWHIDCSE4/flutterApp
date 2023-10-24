// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserLoginAdapter extends TypeAdapter<UserLogin> {
  @override
  final int typeId = 1;

  @override
  UserLogin read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserLogin(
      name: fields[0] as String?,
      avatar: fields[4] as String?,
      phone: fields[1] as String?,
      email: fields[2] as String?,
      token: fields[3] as String?,
      id: fields[5] as int?,
      isHost: fields[6] as bool?,
      isAdmin: fields[7] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, UserLogin obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.token)
      ..writeByte(4)
      ..write(obj.avatar)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.isHost)
      ..writeByte(7)
      ..write(obj.isAdmin);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLoginAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
