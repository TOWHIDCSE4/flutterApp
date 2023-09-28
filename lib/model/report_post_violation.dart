import 'package:gohomy/model/motel_post.dart';
import 'package:gohomy/model/user.dart';

class ReportPostViolation {
  ReportPostViolation(
      {this.id,
      this.moPostId,
      this.reason,
      this.description,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.motelPost});

  int? id;
  int? moPostId;
  String? reason;
  String? description;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  MotelPost? motelPost;
  factory ReportPostViolation.fromJson(Map<String, dynamic> json) =>
      ReportPostViolation(
          id: json["id"],
          moPostId: json["mo_post_id"],
          reason: json["reason"],
          description: json["description"],
          userId: json["user_id"],
          createdAt: json["created_at"] == null
              ? null
              : DateTime.parse(json["created_at"]),
          updatedAt: json["updated_at"] == null
              ? null
              : DateTime.parse(json["updated_at"]),
          user: json['user'] == null ? null : User.fromJson(json['user']),
          motelPost: json['mo_post'] == null
              ? null
              : MotelPost.fromJson(json['mo_post']));

  Map<String, dynamic> toJson() => {
        "id": id,
        "mo_post_id": moPostId,
        "reason": reason,
        "description": description,
        "user_id": userId,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}
