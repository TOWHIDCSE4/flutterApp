


import '../../../../model/report_post_roommate.dart';

class ReportPostRoommateRes {
    int? code;
    bool? success;
    String? msgCode;
    String? msg;
    ReportPostRoommate? data;

    ReportPostRoommateRes({
        this.code,
        this.success,
        this.msgCode,
        this.msg,
        this.data,
    });

    factory ReportPostRoommateRes.fromJson(Map<String, dynamic> json) => ReportPostRoommateRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : ReportPostRoommate.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data?.toJson(),
    };
}




   