import 'package:gohomy/model/post_find_room.dart';

class PostFindRoomRes {
  PostFindRoomRes({
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
  PostFindRoom? data;

  factory PostFindRoomRes.fromJson(Map<String, dynamic> json) =>
      PostFindRoomRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : PostFindRoom.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data?.toJson(),
      };
}
