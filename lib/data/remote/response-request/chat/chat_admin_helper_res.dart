

import 'all_box_chat_res.dart';

class ChatAdminHelperRes {
    int? code;
    String? msgCode;
    String? msg;
    bool? success;
    ChatAdminHelper? data;

    ChatAdminHelperRes({
        this.code,
        this.msgCode,
        this.msg,
        this.success,
        this.data,
    });

    factory ChatAdminHelperRes.fromJson(Map<String, dynamic> json) => ChatAdminHelperRes(
        code: json["code"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        success: json["success"],
        data: json["data"] == null ? null : ChatAdminHelper.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "msg_code": msgCode,
        "msg": msg,
        "success": success,
        "data": data?.toJson(),
    };
}

class ChatAdminHelper {
    List<BoxChat>? adminHelper;
    List<BoxChat>? myHost;

    ChatAdminHelper({
        this.adminHelper,
        this.myHost,
    });

    factory ChatAdminHelper.fromJson(Map<String, dynamic> json) => ChatAdminHelper(
        adminHelper: json["admin_helper"] == null ? [] : List<BoxChat>.from(json["admin_helper"]!.map((x) => BoxChat.fromJson(x))),
        myHost: json["my_host"] == null ? [] : List<BoxChat>.from(json["my_host"]!.map((x) => BoxChat.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "admin_helper": adminHelper == null ? [] : List<dynamic>.from(adminHelper!.map((x) => x.toJson())),
        "my_host": myHost == null ? [] : List<dynamic>.from(myHost!.map((x) => x)),
    };
}

