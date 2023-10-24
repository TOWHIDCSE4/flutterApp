
import 'all_mess_res.dart';

class MessRes {
  MessRes({
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
  Mess? data;

  factory MessRes.fromJson(Map<String, dynamic> json) => MessRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: Mess.fromJson(json["data"]),
  );
}

class ResponseModel {
    final int code;
    final bool success;
    final String msgCode;
    final String msg;

    ResponseModel({
        required this.code,
        required this.success,
        required this.msgCode,
        required this.msg,
    });

    factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
    };
}
