

class ReportStaticPostRoommateRes {
    int? code;
    bool? success;
    String? msgCode;
    String? msg;
    ReportStaticPostRoommate? data;

    ReportStaticPostRoommateRes({
        this.code,
        this.success,
        this.msgCode,
        this.msg,
        this.data,
    });

    factory ReportStaticPostRoommateRes.fromJson(Map<String, dynamic> json) => ReportStaticPostRoommateRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : ReportStaticPostRoommate.fromJson(json["data"]),
    );

}

class ReportStaticPostRoommate {
    List<PostRoommateChart>? charts;
    String? typeChart;
    int? totalPostRoommate;
    int? totalPostRoommateApproved;
    int? totalPostRoommatePending;
    int? totalPostRoommateCancel;
    int? totalPostRoommateVerified;
    int? totalPostRoommateUnverified;
    DateTime? time;

    ReportStaticPostRoommate({
        this.charts,
        this.typeChart,
        this.totalPostRoommate,
        this.totalPostRoommateApproved,
        this.totalPostRoommatePending,
        this.totalPostRoommateCancel,
        this.totalPostRoommateVerified,
        this.totalPostRoommateUnverified,
        this.time,
    });

    factory ReportStaticPostRoommate.fromJson(Map<String, dynamic> json) => ReportStaticPostRoommate(
        charts: json["charts"] == null ? [] : List<PostRoommateChart>.from(json["charts"]!.map((x) => PostRoommateChart.fromJson(x))),
        typeChart: json["type_chart"],
        totalPostRoommate: json["total_post_roommate"],
        totalPostRoommateApproved: json["total_post_roommate_approved"],
        totalPostRoommatePending: json["total_post_roommate_pending"],
        totalPostRoommateCancel: json["total_post_roommate_cancel"],
        totalPostRoommateVerified: json["total_post_roommate_verified"],
        totalPostRoommateUnverified: json["total_post_roommate_unverified"],
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
    );

  
}

class PostRoommateChart {
  PostRoommateChart({
    this.totalPostRoommate,
    this.totalPostRoommateApproved,
    this.totalPostRoommatePending,
    this.totalPostRoommateCancel,
    this.totalPostRoommateVerified,
    this.totalPostRoommateUnverified,
    this.time,
  });

  int? totalPostRoommate;
  int? totalPostRoommateApproved;
  int? totalPostRoommatePending;
  int? totalPostRoommateCancel;
  int? totalPostRoommateVerified;
  int? totalPostRoommateUnverified;
  DateTime? time;

  factory PostRoommateChart.fromJson(Map<String, dynamic> json) => PostRoommateChart(
    totalPostRoommate: json["total_post_roommate"],
    totalPostRoommateApproved: json["total_post_roommate_approved"],
    totalPostRoommatePending: json["total_post_roommate_pending"],
    totalPostRoommateCancel: json["total_post_roommate_cancel"],
    totalPostRoommateVerified: json["total_post_roommate_verified"],
    totalPostRoommateUnverified: json["total_post_roommate_unverified"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
  );

}
