import 'package:gohomy/model/motel_post.dart';

import '../../../../model/user.dart';

class AllMessRes {
  AllMessRes({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
    this.toUser
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  Data? data;
  User? toUser;

  factory AllMessRes.fromJson(Map<String, dynamic> json) => AllMessRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
        toUser : json['to_user'] == null ? null : User.fromJson(json['to_user'])
      );
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  int? currentPage;
  List<Mess>? data;
  String? nextPageUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Mess>.from(json["data"].map((x) => Mess.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );
}

class Mess {
  Mess({
    this.id,
    this.userId,
    this.vsUserId,
    this.vsUser,
    this.user,
    this.isSender,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.type,
    this.motelPost,
  });

  String? id;
  int? userId;
  int? toGroupId;
  int? vsUserId;
  User? vsUser;
  User? user;
  bool? isSender;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String>? images;
  int? type;
  List<MotelPost>? motelPost;

  factory Mess.fromJson(Map<String, dynamic> json) => Mess(
        id: json["id"] == null ? null : json["id"].toString(),
        userId: json["user_id"],
        vsUserId: json["vs_user_id"],
        vsUser: json["vs_user"] == null ? null : User.fromJson(json["vs_user"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    motelPost: json["mo_posts"] == null ? [] : List<MotelPost>.from(json["mo_posts"]!.map((x) => MotelPost.fromJson(x))),
        isSender: json["is_sender"],
        content: json["content"],
        type: json["type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        'id': id == null ? null : content,
        "images": List<dynamic>.from(images!.map((x) => x)),
      };
}
