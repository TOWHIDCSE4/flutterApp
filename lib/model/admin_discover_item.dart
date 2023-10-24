class AdminDiscoverItem {
  AdminDiscoverItem({
    this.id,
    this.adminDiscoverId,
    this.content,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.district,
    this.districtName,
  });

  int? id;
  int? adminDiscoverId;
  String? content;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? district;
  String? districtName;

  factory AdminDiscoverItem.fromJson(Map<String, dynamic> json) =>
      AdminDiscoverItem(
          id: json["id"],
          adminDiscoverId: json["admin_discover_id"],
          content: json["content"],
          image: json["image"],
          createdAt: json["created_at"] == null
              ? null
              : DateTime.parse(json["created_at"]),
          updatedAt: json["updated_at"] == null
              ? null
              : DateTime.parse(json["updated_at"]),
          district: json['district'],
          districtName:
              json['district_name']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "admin_discover_id": adminDiscoverId,
        "content": content,
        "image": image,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "district": district
      };
}
