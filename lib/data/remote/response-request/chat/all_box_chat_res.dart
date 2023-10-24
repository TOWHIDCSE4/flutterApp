import '../../../../model/user.dart';

class AllBoxChatRes {
  AllBoxChatRes({
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
  ChatPersonData? data;

  factory AllBoxChatRes.fromJson(Map<String, dynamic> json) => AllBoxChatRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: ChatPersonData.fromJson(json["data"]),
      );
}

class ChatPersonData {
  ChatPersonData({
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  int? currentPage;
  List<BoxChat>? data;

  String? nextPageUrl;

  factory ChatPersonData.fromJson(Map<String, dynamic> json) => ChatPersonData(
        currentPage: json["current_page"],
        data: List<BoxChat>.from(json["data"].map((x) => BoxChat.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );
}

class BoxChat {
  BoxChat(
      {this.id,
      this.userId,
      this.vsUserId,
      this.lastMess,
      this.seen,
      this.createdAt,
      this.updatedAt,
      this.toUser,
      this.lastListMoPostId,
      this.isHelper,
      this.isMyHost,
      this.isMyRenter,
      this.isMyLastMessage});

  int? id;
  int? userId;
  int? vsUserId;
  String? lastMess;
  bool? seen;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? toUser;
  List<int>? lastListMoPostId;
  bool? isHelper;
  bool? isMyHost;
  bool? isMyRenter;
  int? isMyLastMessage;

  factory BoxChat.fromJson(Map<String, dynamic> json) => BoxChat(
      id: json["id"],
      userId: json["user_id"],
      vsUserId: json["vs_user_id"],
      lastMess: json["last_mess"],
      seen: json["seen"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      lastListMoPostId: json["last_list_mo_post_id"] == null
          ? []
          : List<int>.from(json["last_list_mo_post_id"]!.map((x) => x)),
      toUser: json["to_user"] == null ? null : User.fromJson(json["to_user"]),
      isHelper: json["is_helper"],
      // isMyHost: json["is_my_host"],
      isMyRenter: json["is_my_renter"],
      isMyLastMessage: json["is_my_last_message"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "vs_user_id": vsUserId,
        "last_mess": lastMess,
        "seen": seen,
        "to_user": toUser,
      };
}
