import 'package:gohomy/model/motel_room.dart';

class MotelRoomRes {
  MotelRoomRes({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  MotelRoom? data;

  factory MotelRoomRes.fromJson(Map<String, dynamic> json) =>
      MotelRoomRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : MotelRoom.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data == null ? null : data!.toJson(),
      };
}
