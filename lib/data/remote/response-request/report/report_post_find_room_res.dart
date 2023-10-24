

class ReportStaticPostFindRoomRes {
    int? code;
    bool? success;
    String? msgCode;
    String? msg;
    ReportStaticPostFindRoom? data;

    ReportStaticPostFindRoomRes({
        this.code,
        this.success,
        this.msgCode,
        this.msg,
        this.data,
    });

    factory ReportStaticPostFindRoomRes.fromJson(Map<String, dynamic> json) => ReportStaticPostFindRoomRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : ReportStaticPostFindRoom.fromJson(json["data"]),
    );

}

class ReportStaticPostFindRoom {
    List<PostFindRoomChart>? charts;
    String? typeChart;
    int? totalPostFindMotel;
    int? totalPostFindMotelApproved;
    int? totalPostFindMotelPending;
    int? totalPostFindMotelCancel;
    int? totalPostFindMotelVerified;
    int? totalPostFindMotelUnverified;
    DateTime? time;

    ReportStaticPostFindRoom({
        this.charts,
        this.typeChart,
        this.totalPostFindMotel,
        this.totalPostFindMotelApproved,
        this.totalPostFindMotelPending,
        this.totalPostFindMotelCancel,
        this.totalPostFindMotelVerified,
        this.totalPostFindMotelUnverified,
        this.time,
    });

    factory ReportStaticPostFindRoom.fromJson(Map<String, dynamic> json) => ReportStaticPostFindRoom(
        charts: json["charts"] == null ? [] : List<PostFindRoomChart>.from(json["charts"]!.map((x) => PostFindRoomChart.fromJson(x))),
        typeChart: json["type_chart"],
        totalPostFindMotel: json["total_post_find_motel"],
        totalPostFindMotelApproved: json["total_post_find_motel_approved"],
        totalPostFindMotelPending: json["total_post_find_motel_pending"],
        totalPostFindMotelCancel: json["total_post_find_motel_cancel"],
        totalPostFindMotelVerified: json["total_post_find_motel_verified"],
        totalPostFindMotelUnverified: json["total_post_find_motel_unverified"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
    );

  
}

class PostFindRoomChart {
  PostFindRoomChart({
    this.totalPostFindMotel,
    this.totalPostFindMotelApproved,
    this.totalPostFindMotelPending,
    this.totalPostFindMotelCancel,
    this.totalPostFindMotelVerified,
    this.totalPostFindMotelUnverified,
    this.time,
  });

  int? totalPostFindMotel;
  int? totalPostFindMotelApproved;
  int? totalPostFindMotelPending;
  int? totalPostFindMotelCancel;
  int? totalPostFindMotelVerified;
  int? totalPostFindMotelUnverified;
  DateTime? time;

  factory PostFindRoomChart.fromJson(Map<String, dynamic> json) => PostFindRoomChart(
    totalPostFindMotel: json["total_post_find_motel"],
    totalPostFindMotelApproved: json["total_post_find_motel_approved"],
    totalPostFindMotelPending: json["total_post_find_motel_pending"],
    totalPostFindMotelCancel: json["total_post_find_motel_cancel"],
    totalPostFindMotelVerified: json["total_post_find_motel_verified"],
    totalPostFindMotelUnverified: json["total_post_find_motel_unverified"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
  );

}
