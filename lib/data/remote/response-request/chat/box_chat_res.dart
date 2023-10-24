

import 'all_box_chat_res.dart';

class BoxChatRes {
    int? code;
    String? msgCode;
    String? msg;
    bool? success;
    BoxChat? data;

    BoxChatRes({
        this.code,
        this.msgCode,
        this.msg,
        this.success,
        this.data,
    });

    factory BoxChatRes.fromJson(Map<String, dynamic> json) => BoxChatRes(
        code: json["code"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        success: json["success"],
        data: json["data"] == null ? null : BoxChat.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "msg_code": msgCode,
        "msg": msg,
        "success": success,
        "data": data?.toJson(),
    };
}

