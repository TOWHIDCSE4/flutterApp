

class AllNotiUserRes {
    int? code;
    bool? success;
    String? msgCode;
    String? msg;
    List<NotiUser>? data;

    AllNotiUserRes({
        this.code,
        this.success,
        this.msgCode,
        this.msg,
        this.data,
    });

    factory AllNotiUserRes.fromJson(Map<String, dynamic> json) => AllNotiUserRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<NotiUser>.from(json["data"]!.map((x) => NotiUser.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class NotiUser {
    int? userId;
    int? notiUnread;

    NotiUser({
        this.userId,
        this.notiUnread,
    });

    factory NotiUser.fromJson(Map<String, dynamic> json) => NotiUser(
        userId: json["user_id"],
        notiUnread: json["noti_unread"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "noti_unread": notiUnread,
    };
}
