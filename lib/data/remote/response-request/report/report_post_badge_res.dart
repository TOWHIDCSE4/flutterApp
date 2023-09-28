import 'package:gohomy/model/motel_post.dart';

class ReportPostBadgeRes {
  ReportPostBadgeRes({
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
  ReportPostBadge? data;

  factory ReportPostBadgeRes.fromJson(Map<String, dynamic> json) =>
      ReportPostBadgeRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null
            ? null
            : ReportPostBadge.fromJson(json["data"]),
      );
}

class ReportPostBadge {
  ReportPostBadge({
    this.topViewMoPost,
    this.topFavoritesMoPost,
  });

  List<TopMoPost>? topViewMoPost;
  List<TopMoPost>? topFavoritesMoPost;

  factory ReportPostBadge.fromJson(Map<String, dynamic> json) =>
      ReportPostBadge(
        topViewMoPost: json["top_view_mo_post"] == null
            ? null
            : List<TopMoPost>.from(
                json["top_view_mo_post"].map((x) => TopMoPost.fromJson(x))),
        topFavoritesMoPost: json["top_favorites_mo_post"] == null
            ? null
            : List<TopMoPost>.from(json["top_favorites_mo_post"]
                .map((x) => TopMoPost.fromJson(x))),
      );
}

class TopMoPost {
  TopMoPost({
    this.moPostId,
    this.quantity,
    this.moPost,
  });

  int? moPostId;
  int? quantity;
  MotelPost? moPost;

  factory TopMoPost.fromJson(Map<String, dynamic> json) => TopMoPost(
        moPostId: json["mo_post_id"],
        quantity: json["quantity"],
        moPost: json["mo_post"] == null
            ? null
            : MotelPost.fromJson(json["mo_post"]),
      );
}
