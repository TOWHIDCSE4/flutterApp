class AdminDiscover {
  AdminDiscover({
    this.id,
    this.province,
    this.provinceName,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.content,
    this.listDiscoverItem,
  });

  int? id;
  int? province;
  String? provinceName;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic content;
  List<ListDiscoverItem>? listDiscoverItem;

  factory AdminDiscover.fromJson(Map<String, dynamic> json) => AdminDiscover(
        id: json["id"],
        province: json["province"],
        provinceName:
            json["province_name"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        content: json["content"],
        listDiscoverItem: json["list_discover_item"] == null
            ? null
            : List<ListDiscoverItem>.from(json["list_discover_item"]
                .map((x) => ListDiscoverItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "province": province,
        "province_name": provinceName,
        "image": image,
        "content": content,
        "list_discover_item": listDiscoverItem == null
            ? null
            : List<dynamic>.from(listDiscoverItem!.map((x) => x.toJson())),
      };
}

class ListDiscoverItem {
  ListDiscoverItem({
    this.id,
    this.adminDiscoverId,
    this.content,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.district,
    this.districtName,
    this.totalMoPost
  });

  int? id;
  int? adminDiscoverId;
  String? content;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? district;
  String? districtName;
  int? totalMoPost;

  factory ListDiscoverItem.fromJson(Map<String, dynamic> json) =>
      ListDiscoverItem(
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
        district: json["district"],
        districtName:
            json["district_name"],
        totalMoPost: json['total_mo_post']
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "admin_discover_id": adminDiscoverId,
        "content": content,
        "image": image,
        "district": district,
        "district_name": districtName,
        "total_mo_post":totalMoPost
      };
}
