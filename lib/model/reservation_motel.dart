import 'motel_post.dart';
import 'user.dart';

class ReservationMotel {
  ReservationMotel({
    this.moPostId,
    this.hostId,
    this.name,
    this.phoneNumber,
    this.status,
    this.province,
    this.district,
    this.wards,
    this.note,
    this.provinceName,
    this.districtName,
    this.wardsName,
    this.addressDetail,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.user,
    this.host,
    this.motelPost,
  });

  int? moPostId;
  int? hostId;
  String? name;
  String? phoneNumber;
  int? status;
  int? province;
  int? district;
  int? wards;
  String? note;
  String? provinceName;
  String? districtName;
  String? wardsName;
  String? addressDetail;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  User? user;
  User? host;
  MotelPost? motelPost;

  factory ReservationMotel.fromJson(Map<String, dynamic> json) =>
      ReservationMotel(
        moPostId: json["mo_post_id"],
        hostId: json["host_id"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        status: json["status"],
        province: json["province"],
        district: json["district"],
        wards: json["wards"],
        note: json["note"],
        provinceName:
            json["province_name"],
        districtName:
            json["district_name"],
        wardsName: json["wards_name"],
        addressDetail:
            json["address_detail"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        host: json["host"] == null ? null : User.fromJson(json["host"]),
        motelPost: json["mo_post"] == null
            ? null
            : MotelPost.fromJson(json["mo_post"]),
      );

  Map<String, dynamic> toJson() => {
        "mo_post_id": moPostId,
        "host_id": hostId,
        "name": name,
        "phone_number": phoneNumber,
        "status": status,
        "province": province,
        "district": district,
        "wards": wards,
        "note": note,
        "province_name": provinceName,
        "district_name": districtName,
        "wards_name": wardsName,
        "address_detail": addressDetail,
        "id": id,
      };
}