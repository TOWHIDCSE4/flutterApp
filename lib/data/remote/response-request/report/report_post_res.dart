class ReportPostRes {
  ReportPostRes({
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
  ReportPost? data;

  factory ReportPostRes.fromJson(Map<String, dynamic> json) => ReportPostRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? null : ReportPost.fromJson(json["data"]),
  );
}

class ReportPost {
  ReportPost({
    this.charts,
    this.typeChart,
    this.totalMoPost,
    this.totalMoPostApproved,
    this.totalMoPostPending,
    this.totalMoPostCancel,
    this.totalMoPostVerified,
    this.totalMoPostUnverified,
    this.time,
  });

  List<PostChart>? charts;
  String? typeChart;
  int? totalMoPost;
  int? totalMoPostApproved;
  int? totalMoPostPending;
  int? totalMoPostCancel;
  int? totalMoPostVerified;
  int? totalMoPostUnverified;
  DateTime? time;

  factory ReportPost.fromJson(Map<String, dynamic> json) => ReportPost(
    charts: json["charts"] == null ? null : List<PostChart>.from(json["charts"].map((x) => PostChart.fromJson(x))),
    typeChart: json["type_chart"],
    totalMoPost: json["total_mo_post"],
    totalMoPostApproved: json["total_mo_post_approved"],
    totalMoPostPending: json["total_mo_post_pending"],
    totalMoPostCancel: json["total_mo_post_cancel"],
    totalMoPostVerified: json["total_mo_post_verified"],
    totalMoPostUnverified: json["total_mo_post_unverified"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
  );

}

class PostChart {
  PostChart({
    this.totalMoPost,
    this.totalMoPostApproved,
    this.totalMoPostPending,
    this.totalMoPostCancel,
    this.totalMoPostVerified,
    this.totalMoPostUnverified,
    this.time,
  });

  int? totalMoPost;
  int? totalMoPostApproved;
  int? totalMoPostPending;
  int? totalMoPostCancel;
  int? totalMoPostVerified;
  int? totalMoPostUnverified;
  DateTime? time;

  factory PostChart.fromJson(Map<String, dynamic> json) => PostChart(
    totalMoPost: json["total_mo_post"],
    totalMoPostApproved: json["total_mo_post_approved"],
    totalMoPostPending: json["total_mo_post_pending"],
    totalMoPostCancel: json["total_mo_post_cancel"],
    totalMoPostVerified: json["total_mo_post_verified"],
    totalMoPostUnverified: json["total_mo_post_unverified"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
  );

}
