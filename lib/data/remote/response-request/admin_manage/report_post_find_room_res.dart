



import '../../../../model/report_post_find_room.dart';

class ReportPostFindRoomRes {
    int? code;
    bool? success;
    String? msgCode;
    String? msg;
    ReportPostFindRoom? data;

    ReportPostFindRoomRes({
        this.code,
        this.success,
        this.msgCode,
        this.msg,
        this.data,
    });

    factory ReportPostFindRoomRes.fromJson(Map<String, dynamic> json) => ReportPostFindRoomRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : ReportPostFindRoom.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data?.toJson(),
    };
}



