class Banners {
  Banners({
    this.id,
    this.imageUrl,
    this.title,
    this.actionLink,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? imageUrl;
  String? title;
  String? actionLink;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Banners.fromJson(Map<String, dynamic> json) => Banners(
        id: json["id"],
        imageUrl: json["image_url"],
        title: json["title"],
        actionLink: json["action_link"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "title": title,
        "action_link": actionLink,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}
