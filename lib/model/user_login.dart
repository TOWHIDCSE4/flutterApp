import 'package:hive/hive.dart';

part 'user_login.g.dart';

@HiveType(typeId: 1)
class UserLogin {
  UserLogin({
    this.name,
    this.avatar,
    this.phone,
    this.email,
    this.token,
    this.id,
    this.isHost,
    this.isAdmin
  });

  @HiveField(0)
  String? name;
  @HiveField(1)
  String? phone;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? token;
  @HiveField(4)
  String? avatar;
  @HiveField(5)
  int? id;
  @HiveField(6)
  bool? isHost;
  @HiveField(7)
  bool? isAdmin;
}
