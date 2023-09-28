import 'package:gohomy/model/post_find_room.dart';
import 'package:gohomy/model/user.dart';

class ReportPostFindRoom {
    String? reason;
    String? description;
    int? moPostFindMotelId;
    int? status;
    int? userId;
    DateTime? updatedAt;
    DateTime? createdAt;
    int? id;
    User? user;
    PostFindRoom? moPostFindMotel;

    ReportPostFindRoom({
        this.reason,
        this.description,
        this.moPostFindMotelId,
        this.status,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.user,
        this.moPostFindMotel,
    });

    factory ReportPostFindRoom.fromJson(Map<String, dynamic> json) => ReportPostFindRoom(
        reason: json["reason"],
        description: json["description"],
        moPostFindMotelId: json["mo_post_find_motel_id"],
        status: json["status"],
        userId: json["user_id"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        moPostFindMotel: json["mo_post_find_motel"] == null ? null : PostFindRoom.fromJson(json["mo_post_find_motel"]),
    );

    Map<String, dynamic> toJson() => {
        "reason": reason,
        "description": description,
        "mo_post_find_motel_id": moPostFindMotelId,
        "status": status,
        "user_id": userId,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "user": user?.toJson(),
        "mo_post_find_motel": moPostFindMotel?.toJson(),
    };
}