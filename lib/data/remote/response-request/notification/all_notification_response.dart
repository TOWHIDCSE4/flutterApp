import '../../../../model/notification_user.dart';

class AllNotificationResponse {
  AllNotificationResponse({
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
  Data? data;

  factory AllNotificationResponse.fromJson(Map<String, dynamic> json) =>
      AllNotificationResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.totalUnread,
    this.listNotification,
  });

  int? totalUnread;
  ListNotification? listNotification;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalUnread: json["total_unread"],
        listNotification: json["list_notification"] == null
            ? null
            : ListNotification.fromJson(json["list_notification"]),
      );
}

class ListNotification {
  ListNotification({
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  int? currentPage;
  List<NotificationUser>? data;
  String? nextPageUrl;

  factory ListNotification.fromJson(Map<String, dynamic> json) =>
      ListNotification(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? null
            : List<NotificationUser>.from(
                json["data"].map((x) => NotificationUser.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );
}
