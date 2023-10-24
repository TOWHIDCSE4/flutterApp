import 'package:gohomy/model/user.dart';

import 'motel_room.dart';

class Problem {
  Problem({
    this.id,
    this.userId,
    this.motelId,
    this.reason,
    this.describeProblem,
    this.status,
    this.severity,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.linkVideo,
    this.nameStatus,
    this.nameSeverity,
    this.user,
    this.motel,
  });

  int? id;
  int? userId;
  int? motelId;
  String? reason;
  String? describeProblem;
  String? linkVideo;
  int? status;
  int? severity;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String>? images;
  String? nameStatus;
  String? nameSeverity;
  User? user;
  MotelRoom? motel;

  factory Problem.fromJson(Map<String, dynamic> json) => Problem(
    id: json["id"],
    userId: json["user_id"],
    motelId: json["motel_id"],
    reason: json["reason"],
    describeProblem: json["describe_problem"],
    status: json["status"],
    linkVideo: json["link_video"],
    severity: json["severity"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    images: json["images"] == null ? null : List<String>.from(json["images"].map((x) => x)),
    nameStatus: json["name_status"],
    nameSeverity: json["name_severity"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    motel: json["motel"] == null ? null : MotelRoom.fromJson(json["motel"]),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "motel_id": motelId,
    "reason": reason,
    "describe_problem": describeProblem,
    "status": status,
    "severity": severity,
    "images": images == null ? null : List<dynamic>.from(images!.map((x) => x)),
    "name_status": nameStatus,
    "link_video": linkVideo,
    "name_severity": nameSeverity,
  };
}